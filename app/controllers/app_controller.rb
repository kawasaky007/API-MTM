# frozen_string_literal: true

class AppController < ApplicationController
  def authorize_request
    super
    return if @current_user.resgistation_activated?

    render Response.messaging(
      data: Response::AUTHORIZATION[:UNACTIVE],
      status: :forbidden
    )
  end

  def signin
    validate_features = params.permit(User::USER_PARAMS[:LOGINALBLE])
    user = User.find_by(validate_features.compact) # remove key if it has null value
    token = ''

    if user&.authenticate(params[:password])
      token = Crypto.generate_token(user) if user&.resgistation_activated?
      render Response.data(
        data: { token: token,
                full_name: user.full_name,
                email: user.email,
                active: user.resgistation_activated }
      )
    else
      render Response.messaging(
        data: Response::AUTHORIZATION[:LOGIN_FAIL],
        status: :unauthorized
      )
    end
  end

  def signup
    user = User.new(user_params)

    if User.generate_new_code(user).save
      CodeMailer.code(email: user.email, code: user.auth_code).deliver_later

      render Response.data(
        data: { full_name: user.full_name,
                email: user.email }
      )
    else
      render Response.messaging(
        data: user.errors.full_messages,
        status: :unprocessable_entity
      )
    end
  end

  def send_code
    user = User.find_by(email: params[:email])
    if user
      User.generate_new_code(user).save
      CodeMailer.code(email: user.email, code: user.auth_code).deliver_later

      render Response.success
    else
      render Response.messaging(
        data: Response::USER[:EMAIL_NOT_FOUND],
        status: :not_found
      )
    end
  end

  def check_code
    user = User.find_by(params.permit(:auth_code, :email))
    if user && !Crypto.expired_code?(user)
      user.resgistation_activated = true
      User.generate_new_code(user).save

      token = Crypto.generate_token(user)
      render Response.data(data: { token: token, full_name: user.full_name })
    else
      render Response.messaging(
        data: Response::AUTHORIZATION[:AUTH_CODE],
        status: :unauthorized
      )
    end
  end

  private

  def user_params
    params.require(User.singular_name)
          .permit(User::USER_PARAMS[:CHANGEABLE], :password)
  end
end
