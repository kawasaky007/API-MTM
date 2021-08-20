# frozen_string_literal: true

class V1::Admin::BannersSerializer < ActiveModel::Serializer
  attributes Banner::ADMIN_PARAMS[:SHOWABLE]

  def name
    object.name || ''
  end
end
