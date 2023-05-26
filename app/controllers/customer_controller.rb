class CustomerController < ApplicationController

    def index
        @customers = Customer.all
        render json: @customers
    end

    def create
        puts "parâmetros deu bom? #{customer_params}"
        @store = Store.find(params[:store_id])
        
        @customer = Customer.new(customer_params)

        @customer.store = @store

        if @customer.save
            render json: @customer, status: :created
        else
            render json: @customer.errors, status: :unprocessable_entity
        end
    end

    def show
        @customer = Customer.find(params[:id])
        render json: @customer
    end

    def search_by_attr
        query = Customer.all

        query = query.where("name LIKE ?", "%#{params[:name]}%") if params[:name].present?
        query = query.where("address LIKE ?", "%#{params[:address]}%") if params[:address].present?
        query = query.where("email LIKE ?", "%#{params[:email]}%") if params[:email].present?
        query = query.where("phone LIKE ?", "%#{params[:phone]}%") if params[:phone].present?
        query = query.where("cpf LIKE ?", "%#{params[:cpf]}%") if params[:cpf].present?

        @customers = query
        render json: @customers
    end

    def update
        @store = Store.find(params[:store_id])
        @customer = Customer.find(params[:id])
        @customer.store = @store

        if @customer.update(customer_params)
            render json: @customer
        else
            render :edit
        end
    end

    def destroy
        @customer = Customer.find(params[:id])
        @customer.destroy

        redirect_to customers_path
    end

    private

    def customer_params
        params.require(:customer).permit(:name, :address,:email, :phone, :cpf, :store_id)
    end
end
