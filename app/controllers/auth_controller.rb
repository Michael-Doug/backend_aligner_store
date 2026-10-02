class AuthController < ApplicationController
  skip_before_action :authenticate!

  def signup
    user = User.new(signup_params)
    user.customer = Customer.find_by(email: user.email)

    if user.save
      render json: session_payload(user), status: :created
    else
      render json: { errors: user.errors }, status: :unprocessable_entity
    end
  end

  def login
    user = User.find_by(email: params[:email].to_s.strip.downcase)

    if user&.authenticate(params[:password].to_s)
      render json: session_payload(user)
    else
      render json: { error: "E-mail ou senha inválidos" }, status: :unauthorized
    end
  end

  def me
    authenticate!
    return if performed?

    render json: user_payload(current_user)
  end

  private

  def signup_params
    params.require(:user).permit(:email, :password)
  end

  def session_payload(user)
    { token: AuthToken.encode(user), user: user_payload(user) }
  end

  def user_payload(user)
    { id: user.id, email: user.email, role: user.role, customer_id: user.customer_id }
  end
end
