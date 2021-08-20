# frozen_string_literal: true

class V1::App::CategoriesSerializer < ActiveModel::Serializer
  attributes Category::USER_PARAMS[:SHOWABLE]
  attribute :products, if: -> { @instance_options[:products] }
  attribute :brands, if: -> { @instance_options[:brands] }
  attribute :children
  attribute :parent_name

  def initialize(*arg)
    super
    @instance_options[:level] ||= CONST::DEFAULT_CATE_DEP
  end

  def children
    return [] if stop_condition

    Helpers::SerializerHelpers.each(
      object.children.map,
      each_serializer: V1::App::CategoriesSerializer,
      nested: @instance_options[:nested],
      level: @instance_options[:level] - 1
    )
  end

  def products
    Helpers::SerializerHelpers.each(
      object.products.limit(CONST::DEFAULT_PRODUCT_IN_CATE),
      each_serializer: V1::App::ListProductsSerializer
    )
  end

  def parent_name
    if object.parent_id
      object.parent.name
    else
      ''
    end
  end

  def brands
    Helpers::SerializerHelpers.each(
      object.list_brands,
      each_serializer: V1::App::CategoriesSerializer
    )
  end

  private

  def stop_condition
    !@instance_options[:nested].eql?('true') && !@instance_options[:level].zero?
  end
end
