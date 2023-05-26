class SellerController < ApplicationController

    def index
        @sellers = Seller.all
        render json: @sellers
    end

    def create
        @store = Store.find(params[:store_id])
        
        @seller = Seller.new(seller_params)

        @seller.store = @store

        if @seller.save
            render json: @seller, status: :created
        else
            render json: @seller.errors, status: :unprocessable_entity
        end
    end

    def show
        @seller = Seller.find(params[:id])
        render json: @seller
    end

    def search_by_attr
        query = Seller.all

        query = query.where("name LIKE ?", "%#{params[:name]}%") if params[:name].present?

        @sellers = query
        render json: @sellers
    end

    def update
        @store = Store.find(params[:store_id])
        @seller = Seller.find(params[:id])
        @seller.store = @store

        if @seller.update(seller_params)
            render json: @seller
        else
            render :edit
        end
    end

    def destroy
        @seller = Seller.find(params[:id])
        @seller.destroy

        redirect_to sellers_path
    end

    private

    def seller_params
        params.require(:seller).permit(:name, :store_id)
    end    
end
