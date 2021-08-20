# frozen_string_literal: true

class V1::Admin::ProductsController < AdminController
  before_action :set_product, only: %i[show update destroy]
  before_action :authorize_request

  def index
    products = Response.paginate(
      Product,
      params[:per_page],
      params[:page],
      V1::Admin::ProductsSerializer
    )
    render products
  end

  def show
    render Response.data(
      data: @product,
      serializer: V1::Admin::ProductsSerializer
    )
  end

  def create
    @product = Product.new(product_params)

    if @product.save
      render Response.data(
        data: @product,
        serializer: V1::Admin::ProductsSerializer,
        status: :created
      )
    else
      render Response.messaging(
        data: @product.errors.full_messages
      )
    end
  end

  def update
    if @product.update(product_params)
      render Response.data(
        data: @product,
        serializer: V1::Admin::ProductsSerializer
      )
    else
      render Response.messaging(
        data: @product.errors.full_messages
      )
    end
  end

  def destroy
    if @product.destroy
      render Response.data(
        data: true
      )
    else
      render Response.data(
        data: @product.errors.full_messages
      )
    end
  end

  private

  def set_product
    @product = Product.find_with_id_or_slug(params[:id])
  end

  def product_params
    params.require(Product.singular_name)
          .permit(*Product::ADMIN_PARAMS[:CHANGEABLE])
  end
end
