class StoreController < ApplicationController

    def index
      puts "agora é index?"
      @stores = Store.all
      render json: @stores
    end
    
    def create
      puts "parâmetros deu bom? #{store_params}"
      @store = Store.new(store_params)
    
      if @store.save
        render json: @store, status: :created
      else
        render json: @store.errors, status: :unprocessable_entity
      end
    end
    
    def show
      puts "funciona?"
      @store = Store.find(params[:id])
      render json: @store
    end
  
=begin 
    def search_by_manager
      @store = Store.where(manager: params[:manager])
      render json: @store
    end
  
    def search_by_address
      @store = Store.where(address: params[:address])
      render json: @store
    end
  
    def search_by_name
      puts "nome??"
      @store = Store.where(name: params[:name])
      render json: @store
    end
  
    def search_by_phone
      puts "passou por aqui?"
      @store = Store.where(phone: params[:phone])
      render json: @store
    end
=end
  
=begin
    def search_by_params
      puts "passou pelos atributos?"
      if params[:name] || params[:address] || params[:phone] || params[:manager]
        @stores = Store.where("name = ? OR address = ? OR phone = ? OR manager = ?", params[:name], params[:address], params[:phone], params[:manager])
      elsif params[:name]
        @stores = Store.where(name: params[:name])
      elsif params[:address]
        @stores = Store.where(address: params[:address])
      elsif params[:phone]
        @stores = Store.where(phone: params[:phone])
      elsif params[:manager]
        @stores = Store.where(manager: params[:manager])
      else
        @stores = Store.all
      end
      render json: @stores
    end
=end
  
    def search_by_attr
      query = Store.all
  
      query = query.where("name LIKE ?", "%#{params[:name]}%") if params[:name].present?
      query = query.where("manager LIKE ?", "%#{params[:manager]}%") if params[:manager].present?
      query = query.where("address LIKE ?", "%#{params[:address]}%") if params[:address].present?
  
      @stores = query
      render json: @stores
    end
  
    
    def update
      puts "método update"
      @store = Store.find(params[:id])
    
      if @store.update(store_params)
        render json: @store
      else
        render :edit
      end
    end
    
    def destroy
      @store = Store.find(params[:id])
      @store.destroy
    
      redirect_to stores_path
    end
    
    private
    
    def store_params
      params.require(:store).permit(:name, :address, :manager)
    end
end
