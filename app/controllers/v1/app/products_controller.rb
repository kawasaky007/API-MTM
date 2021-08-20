# frozen_string_literal: true

class V1::App::ProductsController < ApplicationController
  before_action :set_product, only: :show
  before_action :authorize_request, only: %i[add_to_order remove_from_order]
  before_action :set_product, only: %i[order_product_params show add_to_order remove_from_order]

  def index
    products = Response.paginate(
      Product,
      params[:per_page],
      params[:page],
      V1::App::ProductsSerializer
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

  def new_products
    products = Response.paginate(
      Product,
      params[:per_page],
      params[:page],
      V1::App::ProductsSerializer
    ) do |value|
      value
        .categories_filter(*params_array_ids(:brands))
        .order(created_at: :desc)
        .search(
          clean_params(
            params.permit(Product::USER_PARAMS[:SHOWABLE])
          )
        )
    end
    render products
  end

  def hot_products
    products = Response.paginate(
      Product,
      params[:per_page],
      params[:page],
      V1::App::ProductsSerializer
    ) do |value|
      value
        .categories_filter(*params_array_ids(:brands))
        .order(amount: :desc)
        .search(
          clean_params(
            params.permit(Product::USER_PARAMS[:SHOWABLE])
          )
        )
    end
    render products
  end

  def sale_off
    products = Response.paginate(
      Product,
      params[:per_page],
      params[:page],
      V1::App::ProductsSerializer
    ) do |value|
      value
        .categories_filter(*params_array_ids(:brands))
        .where.not(flash_sale_detail_id: 0)
        .search(
          clean_params(
            params.permit(Product::USER_PARAMS[:SHOWABLE])
          )
        )
    end
    render products
  end

  def flash_sale_info
    info = Response.data(
      data: FlashSale.current_sale,
      serializer: V1::App::FlashSalesSerializer
    )
    render info
  end

  def show
    product = Response.data(
      data: @product,
      serializer: V1::App::ProductsSerializer,
      related_projects: true
    )
    render product
  end

  def add_to_order
    status = @current_user.current_saved.add_product(
      clean_params(order_product_params)
    )

    if status.product.errors.full_messages.empty?
      render Response.data(
        data: !status.nil?
      )
    else
      render Response.messaging(
        data: status.product.errors.full_messages
      )
    end
  end

  def remove_from_order
    status = @current_user.current_saved.remove_product(
      clean_params(order_product_params)
    )

    render Response.data(
      data: !status.nil?,
      related_projects: true
    )
  end

  private

  def order_product_params
    params.permit(:amount).merge(
      order: @current_user.current_saved,
      product: @product
    )
  end

  def set_product
    @product = Product.find_with_id_or_slug(params[:id])
  end
end
