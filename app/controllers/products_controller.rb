class ProductsController < ApplicationController
  skip_before_action :authenticate!, only: %i[index show search_by_attr]
  before_action :require_admin!, only: %i[create update destroy]
  before_action :set_product, only: %i[show update destroy]

  def index
    render json: Product.all
  end

  def show
    render json: @product
  end

  def search_by_attr
    scope = apply_filters(Product.all, text: %i[name description], numeric: %i[price])
    render json: scope
  end

  def create
    product = Product.new(product_params)

    if product.save
      render json: product, status: :created
    else
      render json: { errors: product.errors }, status: :unprocessable_entity
    end
  end

  def update
    if @product.update(product_params)
      render json: @product
    else
      render json: { errors: @product.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    @product.destroy
    head :no_content
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :description, :price, :store_id)
  end
end
