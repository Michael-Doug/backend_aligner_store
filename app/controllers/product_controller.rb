class ProductController < ApplicationController

    def index
      @products = Product.all
      render json: @products
    end
    
    def create
      @store = Store.find(params[:store_id])
      @product = Product.new(product_params)

      @product.store = @store
    
      if @product.save
        render json: @product, status: :created
      else
        render json: @product.errors, status: :unprocessable_entity
      end
    end
    
    def show
      @product = Product.find(params[:id])
      render json: @product
    end
  
    def search_by_attr
      query = Product.all
  
      query = query.where("name LIKE ?", "%#{params[:name]}%") if params[:name].present?
      query = query.where("description LIKE ?", "%#{params[:description]}%") if params[:description].present?
      query = query.where("price LIKE ?", "%#{params[:price]}%") if params[:price].present?
  
      @products = query
      render json: @products
    end
  
    
    def update
      
      @store = Store.find(params[:store_id])
      @product = Product.find(params[:id])

      @product.store = @store
    
      if @product.update(product_params)
        render json: @product
      else
        render :edit
      end
    end
    
    def destroy
      @product = Product.find(params[:id])
      @product.destroy
    
      redirect_to products_path
    end
    
    private
    
    def product_params
      params.require(:product).permit(:name, :description, :price, :store_id)
    end

end
