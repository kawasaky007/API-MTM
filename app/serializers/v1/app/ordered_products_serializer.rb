# frozen_string_literal: true

class V1::App::OrderedProductsSerializer < ActiveModel::Serializer
  attributes Product::USER_PARAMS[:LIST_SHOW]
  attribute :price_after_discount

  has_many :photos, serializer: V1::App::PhotosSerializer

  def price
    Helpers::SerializerHelpers.num_format(
      string: object.price.to_s(:delimited),
      num: object.price,
      char: 'đ'
    )
  end

  def price_after_discount
    Helpers::SerializerHelpers.num_format(
      string: object.price_after_discount.to_i.to_s(:delimited),
      num: object.price_after_discount,
      char: 'đ'
    )
  end

  def discount
    Helpers::SerializerHelpers.num_format(
      string: - object.discount_with_sale * 100,
      num: object.discount_with_sale,
      char: '%'
    )
  end

  def amount
    object.ordered_products
          .find_by(
            order_id: @instance_options[:order_id]
          ).amount
  end
end
