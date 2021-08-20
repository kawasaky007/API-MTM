# frozen_string_literal: true

module FlashSaleParams
  extend ActiveSupport::Concern

  included do
    const_set(
      :ADMIN_PARAMS,
      {
        CHANGEABLE: %i[name slug photo popup active_time expired_time].freeze,

        SHOWABLE: %i[id name slug photo popup active_time expired_time].freeze
      }.freeze
    )

    const_set(
      :USER_PARAMS,
      {
        SHOWABLE: %i[id slug name photo active_time expired_time].freeze
      }.freeze
    )
  end
end
