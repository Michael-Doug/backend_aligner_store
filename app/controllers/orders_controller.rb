class OrdersController < ApplicationController
  before_action :set_order, only: %i[show update destroy]

  def index
    render json: Order.all
  end

  def show
    render json: @order, include: :order_items
  end

  def search_by_attr
    render json: apply_filters(Order.all, numeric: %i[total_value customer_id store_id payment_id])
  end

  def create
    order = Order.new(order_params)

    if order.save
      render json: order, status: :created
    else
      render json: { errors: order.errors }, status: :unprocessable_entity
    end
  end

  def update
    if @order.update(order_params)
      render json: @order
    else
      render json: { errors: @order.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    @order.destroy
    head :no_content
  end

  private

  def set_order
    @order = Order.find(params[:id])
  end

  # total_value é sempre calculado a partir dos itens; aceitar do cliente
  # deixaria o pedido fechar por um valor que o cliente escolheu.
  def order_params
    params.require(:order).permit(:customer_id, :store_id, :payment_id)
  end
end
