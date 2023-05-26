class OrderController < ApplicationController

    def index
        @orders = Order.all
        render json: @orders
    end

    def create
        @store = Store.find(params[:store_id])
        @customer = Customer.find(params[:customer_id])
        @payment = Payment.find(params[:payment_id])

        @order = Order.new(order_params)

        @order.store = @store
        @order.customer = @customer
        @order.payment = @payment

        if @order.save
            @order.calculate_order_total_value
            @order.save
            render json: @order, status: :created
        else
            render json: @order.errors, status: :unprocessable_entity
        end
    end

    def show
        @order = Order.find(params[:id])
        render json: @order
    end

    def search_by_attr
        query = Order.all

        query = query.where("total_value LIKE ?", "%#{params[:total_value]}%") if params[:total_value].present?

        @order = query
        render json: @order
    end

    def update
        @store = Store.find(params[:store_id])
        @customer = Customer.find(params[:customer_id])
        @payment = Payment.find(params[:payment_id])

        @order = Order.find(params[:id])

        @order.store = @store
        @order.customer = @customer
        @order.payment = @payment

        if @order.update(order_params)
            render json: @order
        else
            render :edit
        end
    
    end

    def destroy
        @order = Order.find(params[:id])
        @order.destroy

        redirect_to orders_path
    end

    private

    def order_params
        params.require(:order).permit(:total_value, :customer_id, :store_id, :payment_id)
    end
end
