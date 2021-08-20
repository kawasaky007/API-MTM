# frozen_string_literal: true

class V1::App::FlashSalesSerializer < ActiveModel::Serializer
  attributes FlashSale::USER_PARAMS[:SHOWABLE]
  attribute :active

  def active
    Time.zone.now < object.expired_time
  end
end
