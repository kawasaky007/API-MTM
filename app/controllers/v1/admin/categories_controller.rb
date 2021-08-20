# frozen_string_literal: true

class V1::Admin::CategoriesController < AdminController
  before_action :set_category, only: %i[show update destroy]
  before_action :authorize_request

  def index
    categories = Response.paginate(
      Category,
      params[:per_page],
      params[:page],
      V1::Admin::CategoriesSerializer
    ) do |cate|
      if params[:nested].eql?('true')
        cate.only_parents
      else
        cate.all
      end
    end
    render categories
  end

  def show
    render Response.data(
      data: @category,
      serializer: V1::Admin::CategoriesSerializer
    )
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      render Response.data(
        data: @category,
        serializer: V1::Admin::CategoriesSerializer,
        status: :created
      )
    else
      render Response.messaging(
        data: @category.errors.full_messages
      )
    end
  end

  def update
    if @category.update(category_params)
      render Response.data(
        data: @category,
        serializer: V1::Admin::CategoriesSerializer
      )
    else
      render Response.messaging(
        data: @category.errors.full_messages
      )
    end
  end

  def destroy
    if @category.destroy
      render Response.data(
        data: true
      )
    else
      render Response.data(
        data: @category.errors.full_messages
      )
    end
  end

  private

  def set_category
    @category = Category.find_with_id_or_slug(params[:id])
  end

  def category_params
    params.require(Category.singular_name)
          .permit(*Category::ADMIN_PARAMS[:CHANGEABLE])
  end
end
