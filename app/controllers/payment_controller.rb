class PaymentController < ApplicationController

    def index
      @payments = Payment.all
      render json: @payments
    end
    
    def create
      @payment = Payment.new(payment_params)
    
      if @payment.save
        render json: @payment, status: :created
      else
        render json: @payment.errors, status: :unprocessable_entity
      end
    end
    
    def show
      @payment = Payment.find(params[:id])
      render json: @payment
    end
  
    def search_by_attr
      query = Payment.all
  
      query = query.where("name LIKE ?", "%#{params[:name]}%") if params[:name].present?
  
      @payments = query
      render json: @payments
    end
  
    
    def update
      @payment = Payment.find(params[:id])
    
      if @payment.update(payment_params)
        render json: @payment
      else
        render :edit
      end
    end
    
    def destroy
      @payment = Payment.find(params[:id])
      @payment.destroy
    
      redirect_to payments_path
    end
    
    private
    
    def payment_params
      params.require(:payment).permit(:name)
    end
end
