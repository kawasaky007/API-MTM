# frozen_string_literal: true

class V1::App::CategoriesController < ApplicationController
  before_action :set_category, only: %i[show products]

  def index
    categories = Response.paginate(
      Category,
      params[:per_page],
      params[:page],
      V1::App::CategoriesSerializer,
      nested: params[:nested]
    ) do |cate|
      if params[:nested].eql?('true')
        cate.only_parents
      else
        cate.all
      end
    end
    render categories
  end

  def hot_categories
    categories = Response.paginate(
      Category,
      params[:per_page],
      params[:page],
      V1::App::CategoriesSerializer,
      &:hot_categories
    )
    render categories
  end

  def home_page
    categories = Response.paginate(
      Category,
      params[:per_page],
      params[:page],
      V1::App::CategoriesSerializer,
      products: true,
      nested: 'true',
      level: 1,
      &:home_page
    )
    render categories
  end

  def show
    category = Response.data(
      data: @category,
      serializer: V1::App::CategoriesSerializer,
      brands: true
    )
    render category
  end

  def brands
    cate = if params[:id]
             Category.find(params[:id]).list_brands
           else
             Category.brands
           end

    categories = Response.paginate(
      cate,
      params[:per_page],
      params[:page],
      V1::App::CategoriesSerializer
    )
    render categories
  end

  def products
    products = Response.paginate(
      @category.products,
      params[:per_page],
      params[:page],
      V1::App::ListProductsSerializer
    ) do |value|
      value
        .categories_filter(*params_array_ids(:brands))
        .search(
          clean_params(
            params.permit(Product::USER_PARAMS[:SHOWABLE])
          )
        )
    end
    render products
  end

  private

  def set_category
    @category = Category.find_with_id_or_slug(params[:id])
  end
end
