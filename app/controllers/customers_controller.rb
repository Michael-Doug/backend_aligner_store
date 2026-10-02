class CustomersController < ApplicationController
  skip_before_action :authenticate!, only: %i[create]
  before_action :require_admin!, only: %i[index search_by_attr]
  before_action :set_customer, only: %i[show update destroy]
  before_action :authorize_owner!, only: %i[show update destroy]

  def index
    render json: Customer.all
  end

  def show
    render json: @customer
  end

  def search_by_attr
    render json: apply_filters(Customer.all, text: %i[name address email phone cpf])
  end

  def create
    customer = Customer.new(customer_params)

    if customer.save
      render json: customer, status: :created
    else
      render json: { errors: customer.errors }, status: :unprocessable_entity
    end
  end

  def update
    if @customer.update(customer_params)
      render json: @customer
    else
      render json: { errors: @customer.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    @customer.destroy
    head :no_content
  end

  private

  def set_customer
    @customer = Customer.find(params[:id])
  end

  def authorize_owner!
    require_admin_or_owner!(@customer.id)
  end

  def customer_params
    params.require(:customer).permit(:name, :address, :email, :phone, :cpf, :store_id)
  end
end
