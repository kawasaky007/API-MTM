# frozen_string_literal: true

class V1::App::SalesController < ApplicationController
  before_action :set_flash_sale, only: %i[show products]

  def popup
    p_up = Response.data(
      data: FlashSale.popup,
      serializer: V1::App::FlashSalesSerializer
    )
    render p_up
  end

  def flash_sale
    flash_sale = Response.data(
      data: FlashSale.current_sale,
      serializer: V1::App::FlashSalesSerializer
    )
    render flash_sale
  end

  def show
    flash_sale = Response.data(
      data: @flash_sale,
      serializer: V1::App::FlashSalesSerializer
    )
    render flash_sale
  end

  def products
    products = Response.paginate(
      @flash_sale.products,
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

  private

  def set_flash_sale
    @flash_sale = FlashSale.find_with_id_or_slug(params[:id])
  end
end
