# frozen_string_literal: true

class V1::Admin::FlashSalesSerializer < ActiveModel::Serializer
  attributes FlashSale::ADMIN_PARAMS[:SHOWABLE]
  attribute :active

  def active
    Time.zone.now < object.expired_time
  end
end
