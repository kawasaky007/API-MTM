# frozen_string_literal: true

class V1::App::OrdersSerializer < ActiveModel::Serializer
  attributes Order::USER_PARAMS[:SHOWABLE]
  attributes :products

  def price
    Helpers::SerializerHelpers.num_format(
      string: object.price.to_s(:delimited),
      num: object.price,
      char: 'đ'
    )
  end

  def products
    Helpers::SerializerHelpers.each(
      object.products,
      each_serializer: V1::App::OrderedProductsSerializer,
      order_id: object.id
    )
  end
end
