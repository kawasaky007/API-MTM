# frozen_string_literal: true

class V1::App::BannersSerializer < ActiveModel::Serializer
  attributes Banner::USER_PARAMS[:SHOWABLE]

  def name
    object.name || ''
  end
end
