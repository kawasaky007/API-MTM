# frozen_string_literal: true

class V1::App::TransportMethodsSerializer < ActiveModel::Serializer
  attributes :id, :price, :transport_method

  def price
    Helpers::SerializerHelpers.num_format(
      string: object.price.to_s(:delimited),
      num: object.price,
      char: 'đ'
    )
  end
end
