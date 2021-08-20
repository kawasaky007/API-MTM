# frozen_string_literal: true

class AdminController < ApplicationController
  def authorize_request
    super

    if !@current_user.instance_of?(Admin)
      render Response.messaging(
        data: Response::AUTHORIZATION[:PERMS_DENIED],
        status: :forbidden
      )
    elsif !@current_user.active?
      render Response.messaging(
        data: Response::AUTHORIZATION[:UNACTIVE],
        status: :forbidden
      )
    end
  end

  def signin
    validate_features = params.permit(:email, :phone_number)
    user = Admin.find_by(validate_features.compact) # remove null value

    if user&.authenticate(params[:password])
      token = Crypto.generate_token(user)
      render Response.data(
        data: { token: token,
                full_name: user.full_name,
                email: user.email }
      )
    else
      render Response.messaging(
        data: Response::AUTHORIZATION[:LOGIN_FAIL],
        status: :unauthorized
      )
    end
  end
end
