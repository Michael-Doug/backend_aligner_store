class StoresController < ApplicationController
  before_action :set_store, only: %i[show update destroy]

  def index
    render json: Store.all
  end

  def show
    render json: @store
  end

  def search_by_attr
    render json: apply_filters(Store.all, text: %i[name manager address])
  end

  def create
    store = Store.new(store_params)

    if store.save
      render json: store, status: :created
    else
      render json: { errors: store.errors }, status: :unprocessable_entity
    end
  end

  def update
    if @store.update(store_params)
      render json: @store
    else
      render json: { errors: @store.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    @store.destroy
    head :no_content
  end

  private

  def set_store
    @store = Store.find(params[:id])
  end

  def store_params
    params.require(:store).permit(:name, :address, :manager, :phone)
  end
end
