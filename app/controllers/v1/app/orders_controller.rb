# frozen_string_literal: true

class V1::App::OrdersController < ApplicationController
  before_action :authorize_request
  before_action :set_order, only: %i[show create]

  def index
    orders = Response.paginate(
      @current_user.orders,
      params[:per_page],
      params[:page],
      V1::App::OrdersSerializer
    ) do |value|
      value
        .search(
          clean_params(
            params.permit(Order::USER_PARAMS[:SHOWABLE])
          )
        )
    end
    render orders
  end

  def show
    order = Response.data(
      data: @order,
      serializer: V1::App::OrdersSerializer
    )
    render order
  end

  def shoping_cart
    order = Response.data(
      data: @current_user.current_saved,
      serializer: V1::App::OrdersSerializer
    )
    render order
  end

  def transport_method
    methods = Response.paginate(
      Transport,
      params[:per_page],
      params[:page],
      V1::App::TransportMethodsSerializer
    ) do |value|
      value.search(region: params[:location])
    end
    render methods
  end

  def recent_addresses
    addresses = Response.data(
      data: @current_user.orders.recent_addresses
    )
    render addresses
  end

  def create
    if @order.update_by(@current_user, order_params.merge(status: 'ordered'))
      order = Response.data(
        data: @order,
        serializer: V1::App::OrdersSerializer
      )
      render order
    else
      render Response.messaging(
        data: @order.errors.full_messages
      )
    end
  end

  private

  def set_order
    @order = if params[:id]
               Order.find_by(id: params[:id], user: @current_user)
             else
               @current_user.current_saved
             end
  end

  def order_params
    params.require(Order.singular_name)
          .permit(*Order::USER_PARAMS[:CHANGEABLE])
  end
end
