class OrderItemsController < ApplicationController
  before_action :require_admin!, only: %i[index search_by_attr]
  before_action :set_order_item, only: %i[show update destroy]
  before_action :authorize_owner!, only: %i[show update destroy]
  before_action :authorize_order!, only: %i[create]

  def index
    render json: OrderItem.all
  end

  def show
    render json: @order_item
  end

  def search_by_attr
    render json: apply_filters(
      OrderItem.all,
      numeric: %i[quantity unitary_value total_value order_id product_id],
    )
  end

  def create
    order_item = OrderItem.new(order_item_params)

    if order_item.save
      render json: order_item, status: :created
    else
      render json: { errors: order_item.errors }, status: :unprocessable_entity
    end
  end

  def update
    if @order_item.update(order_item_params)
      render json: @order_item
    else
      render json: { errors: @order_item.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    @order_item.destroy
    head :no_content
  end

  private

  def set_order_item
    @order_item = OrderItem.find(params[:id])
  end

  def authorize_owner!
    require_admin_or_owner!(@order_item.order.customer_id)
  end

  def authorize_order!
    require_admin_or_owner!(Order.find(order_item_params[:order_id]).customer_id)
  end

  # unitary_value e total_value vêm do preço do produto, nunca do cliente.
  def order_item_params
    params.require(:order_item).permit(:quantity, :order_id, :product_id)
  end
end
