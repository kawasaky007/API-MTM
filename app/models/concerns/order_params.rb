# frozen_string_literal: true

module OrderParams
  extend ActiveSupport::Concern

  included do
    const_set(
      :ADMIN_PARAMS,
      {
        CHANGEABLE: %i[].freeze,

        SHOWABLE: %i[id full_name email
                     phone_number province district
                     transport_id payment_method price
                     status user_id address
                     created_at updated_at].freeze
      }
    )

    const_set(
      :USER_PARAMS,
      {
        SHOWABLE: %i[id full_name email
                     phone_number province district
                     transport_id payment_method price
                     status address created_at].freeze,

        CHANGEABLE: %i[id full_name email
                       phone_number province district
                       transport_id payment_method address].freeze
      }.freeze
    )
  end
end
