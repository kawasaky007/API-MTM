# frozen_string_literal: true

module CategoryParams
  extend ActiveSupport::Concern

  included do
    const_set(
      :ADMIN_PARAMS,
      {
        CHANGEABLE: %i[name icon parent_id photo color slug].freeze,

        SHOWABLE: %i[id name icon parent_id photo color slug].freeze
      }.freeze
    )

    const_set(
      :USER_PARAMS,
      {
        SHOWABLE: %i[id name icon photo parent_id color slug].freeze
      }.freeze
    )
  end
end
