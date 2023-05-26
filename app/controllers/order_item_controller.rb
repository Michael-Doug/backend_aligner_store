class OrderItemController < ApplicationController

    def index
        @order_items = OrderItem.all
        render json: @order_items
    end

    def create
        @order = Order.find(params[:order_id])
        @product = Product.find(params[:product_id])
    
        @order_item = OrderItem.new(order_item_params)
        @order_item.calculate_order_item_total_value
    
        #garanto que cada item do order_item seja corretamente associado ao order e product correto
        @order_item.order = @order
        @order_item.product = @product
    
        if @order_item.save
            render json: @order_item, status: :created
        else
            render json: @order_item.errors, status: :unprocessable_entity
        end
    end

    def show
        @order_item = OrderItem.find(params[:id])
        render json: @order_item
    end

    def search_by_attr
        query = OrderItem.all

        query = query.where("quantity LIKE ?", "%#{params[:quantity]}%") if params[:quantity].present?
        query = query.where("unitary_value LIKE ?", "%#{params[:unitary_value]}%") if params[:unitary_value].present?
        query = query.where("total_value LIKE ?", "%#{params[:total_value]}%") if params[:total_value].present?

        @order_items = query
        render json: @order_items
    end

    def update
        @order = Order.find(params[:order_id])
        @product = Product.find(params[:product_id])

        @order_item = OrderItem.find(params[:id])

        @order_item.order = @order
        @order_item.product = @product

        if @order_item.update(order_item_params)
            render json: @order_item
        else
            render :edit
        end
    end

    def destroy
        @order_item = OrderItem.find(params[:id])
        @order_item.destroy

        redirect_to order_items_path
    end

    private

    def order_item_params
        params.require(:order_item).permit(:quantity, :unitary_value, :total_value, :order_id, :product_id)
    end
end
