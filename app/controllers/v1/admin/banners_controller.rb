# frozen_string_literal: true

class V1::Admin::BannersController < AdminController
  before_action :authorize_request
  before_action :set_banner, only: %i[show update destroy]

  def index
    banners = Response.paginate(
      Banner,
      params[:per_page],
      params[:page],
      V1::Admin::BannersSerializer
    )
    render banners
  end

  def show
    render Response.data(
      data: @banner,
      serializer: V1::Admin::BannersSerializer
    )
  end

  def create
    @banner = Banner.new(banner_params)

    if @banner.save
      render Response.data(
        data: @banner,
        serializer: V1::Admin::BannersSerializer,
        status: :created
      )
    else
      render Response.messaging(
        data: @banner.errors.full_messages
      )
    end
  end

  def update
    if @banner.update(banner_params)
      render Response.data(
        data: @banner,
        serializer: V1::Admin::BannersSerializer
      )
    else
      render Response.messaging(
        data: @banner.errors.full_messages
      )
    end
  end

  def destroy
    if @banner.destroy
      render Response.data(
        data: true
      )
    else
      render Response.data(
        data: @banner.errors.full_messages
      )
    end
  end

  private

  def set_banner
    @banner = Banner.find_with_id_or_slug(params[:id])
  end

  def banner_params
    params.require(Banner.singular_name)
          .permit(*Banner::ADMIN_PARAMS[:CHANGEABLE])
  end
end
