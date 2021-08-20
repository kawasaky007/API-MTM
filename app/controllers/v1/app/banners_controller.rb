# frozen_string_literal: true

class V1::App::BannersController < ApplicationController
  def index
    banners = Response.paginate(
      Banner,
      params[:per_page],
      params[:page],
      V1::App::BannersSerializer
    )
    render banners
  end
end
