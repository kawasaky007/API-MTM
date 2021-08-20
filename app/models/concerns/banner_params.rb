# frozen_string_literal: true

module BannerParams
  extend ActiveSupport::Concern

  included do
    const_set(
      :ADMIN_PARAMS,
      {
        CHANGEABLE: %i[name url slug].freeze,

        SHOWABLE: %i[id name url slug].freeze
      }.freeze
    )

    const_set(
      :USER_PARAMS,
      {
        SHOWABLE: %i[name url slug].freeze
      }.freeze
    )
  end
end
