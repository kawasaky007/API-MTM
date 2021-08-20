# frozen_string_literal: true

class ApplicationController < ActionController::API
  # include HandleErrors

  def per_page
    pp = params[:per_page] || CONST::PER_PAGE
    pp.to_i
  end

  def params_array_ids(name = :filter)
    return if params[name].nil?

    params[name].split(',').map(&:to_i)
  end

  def clean_params(params)
    params.except(:controller, :action, :id)
  end

  def authorize_request
    headers = request.headers['Authorization']
    token = headers.split(' ').last if headers.present?

    decoded_token = Crypto::JsonWebToken.decode(token)
    @current_user = decoded_token[:from].camelize
                                        .constantize
                                        .find_by(id: decoded_token[:uuid])

    return if !@current_user.nil? || @current_user.auth_code == decoded_token[:auth_code]

    raise JWT::VerificationError
  end
end
