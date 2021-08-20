# frozen_string_literal: true

module ProductParams
  extend ActiveSupport::Concern

  included do
    const_set(
      :ADMIN_PARAMS,
      {
        CHANGEABLE: [:slug, :name, :code, :url, :price, :discount, :details, :amount, :status, { photo_attributes: {} }].freeze,

        SHOWABLE: %i[id slug name code url price discount details amount status photos].freeze,

        LIST_SHOW: %i[id name code url price discount amount photos].freeze
      }.freeze
    )

    const_set(
      :USER_PARAMS,
      {
        SHOWABLE: %i[id slug name code url price discount details amount status photos].freeze,

        LIST_SHOW: %i[id slug name code url price discount amount photos].freeze
      }.freeze
    )
  end
end
