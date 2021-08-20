# frozen_string_literal: true

module UserParams
  extend ActiveSupport::Concern

  included do
    const_set(
      :ADMIN_PARAMS,
      {
        CHANGEABLE: [:phone_number, :full_name, :sex,
                     :password, :email, :address_city,
                     :address_district, :address_ward, :address_details,
                     :resgistation_activated, :dob, { photo_attributes: {} }].freeze,

        SHOWABLE: %i[id phone_number full_name sex
                     email address_city address_district
                     address_ward address_details
                     resgistation_activated dob photo].freeze
      }.freeze
    )

    const_set(
      :USER_PARAMS,
      {
        LOGINALBLE: %i[phone_number email].freeze,

        CHANGEABLE: [:phone_number, :full_name, :sex,
                     :email, :address_city, :address_district,
                     :address_ward, :address_details, :dob,
                     { photo_attributes: {} }].freeze,

        SHOWABLE: %i[phone_number full_name sex
                     email address_city address_district
                     address_ward address_details dob photo].freeze
      }.freeze
    )
  end
end
