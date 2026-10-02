class ApplicationController < ActionController::API
  include Searchable

  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  rescue_from ActionController::ParameterMissing, with: :bad_request

  before_action :authenticate!

  attr_reader :current_user

  private

  def authenticate!
    payload = AuthToken.decode(bearer_token)
    @current_user = User.find_by(id: payload["user_id"]) if payload

    render json: { error: "Não autenticado" }, status: :unauthorized if @current_user.nil?
  end

  def authenticate_optionally
    payload = AuthToken.decode(bearer_token)
    @current_user = User.find_by(id: payload["user_id"]) if payload
  end

  def require_admin!
    return if current_user&.admin?

    render json: { error: "Acesso restrito" }, status: :forbidden
  end

  # Admin passa em tudo; cliente só no que é dele.
  def require_admin_or_owner!(customer_id)
    return if current_user&.admin?
    return if current_user&.customer_id.present? && current_user.customer_id == customer_id

    render json: { error: "Acesso restrito" }, status: :forbidden
  end

  def bearer_token
    request.headers["Authorization"].to_s[/\ABearer (.+)\z/, 1]
  end

  def not_found(exception)
    render json: { error: exception.message }, status: :not_found
  end

  def bad_request(exception)
    render json: { error: exception.message }, status: :bad_request
  end
end
