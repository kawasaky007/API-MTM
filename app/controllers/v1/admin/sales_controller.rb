# frozen_string_literal: true

class V1::Admin::SalesController < AdminController
  before_action :set_flash_sale, only: %i[show update destroy]
  before_action :authorize_request

  def index
    flash_sales = Response.paginate(
      FlashSale,
      params[:per_page],
      params[:page],
      V1::App::FlashSalesSerializer
    )
    render flash_sales
  end

  def show
    render Response.data(
      data: @flash_sale,
      serializer: V1::App::FlashSalesSerializer
    )
  end

  def create
    @flash_sale = FlashSale.new(sale_params)

    if @flash_sale.save
      render Response.data(
        data: @flash_sale,
        serializer: V1::App::FlashSalesSerializer,
        status: :created
      )
    else
      render Response.messaging(
        data: @flash_sale.errors.full_messages
      )
    end
  end

  def update
    if @flash_sale.update(sale_params)
      render Response.data(
        data: @flash_sale,
        serializer: V1::App::FlashSalesSerializer
      )
    else
      render Response.messaging(
        data: @flash_sale.errors.full_messages
      )
    end
  end

  def destroy
    if @flash_sale.destroy
      render Response.data(
        data: true
      )
    else
      render Response.data(
        data: @flash_sale.errors.full_messages
      )
    end
  end

  private

  def set_flash_sale
    @flash_sale = FlashSale.find_with_id_or_slug(params[:id])
  end

  def sale_params
    params.require(FlashSale.singular_name)
          .permit(*FlashSale::ADMIN_PARAMS[:CHANGEABLE])
  end
end
