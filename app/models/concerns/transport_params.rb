# frozen_string_literal: true

module TransportParams
  extend ActiveSupport::Concern

  included do
    const_set(
      :ADMIN_PARAMS,
      {
        CHANGEABLE: %i[name region price transport_method].freeze,

        SHOWABLE: %i[id name region price transport_method].freeze
      }.freeze
    )

    const_set(
      :USER_PARAMS,
      {
        SHOWABLE: %i[id name region price transport_method].freeze
      }.freeze
    )
  end
end
