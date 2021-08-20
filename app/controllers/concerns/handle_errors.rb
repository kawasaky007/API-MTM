# frozen_string_literal: true

module HandleErrors
  extend ActiveSupport::Concern

  included do
    rescue_from StandardError do |exception|
      render Response.messaging(data: exception.message)
    end

    rescue_from ActiveRecord::RecordNotFound do |exception|
      render Response.messaging(data: exception.message, status: :not_found)
    end

    rescue_from JWT::DecodeError do
      render Response.messaging(
        data: Response::USER[:UNAUTH],
        status: :unauthorized
      )
    end

    rescue_from JWT::VerificationError do
      render Response.messaging(
        data: Response::USER[:UNAUTH],
        status: :unauthorized
      )
    end
  end
end
