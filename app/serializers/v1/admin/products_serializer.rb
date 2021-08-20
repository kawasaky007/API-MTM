# frozen_string_literal: true

class V1::Admin::ProductsSerializer < ActiveModel::Serializer
  attributes Product::ADMIN_PARAMS[:SHOWABLE]
  attribute :related_projects, if: -> { @instance_options[:related_projects] }
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

  # show amount if product on saling or flash sale
  def amount
    object.amount if object.on_saling?
  end

  def related_projects
    Helpers::SerializerHelpers.each(
      object.related_projects,
      each_serializer: V1::App::ListProductsSerializer
    )
  end
end
