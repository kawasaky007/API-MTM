# frozen_string_literal: true

class V1::Admin::UsersController < AdminController
  before_action :set_user, only: %i[show update destroy]
  before_action :authorize_request

  def index
    users = Response.paginate(
      User,
      params[:per_page],
      params[:page],
      V1::Admin::UsersSerializer
    )
    render users
  end

  def show
    render Response.data(
      data: @user,
      serializer: V1::Admin::UsersSerializer
    )
  end

  def create
    @user = User.new(user_params)

    if @user.save
      render Response.data(
        data: @user,
        serializer: V1::Admin::UsersSerializer,
        status: :created
      )
    else
      render Response.messaging(
        data: @user.errors.full_messages
      )
    end
  end

  def update
    if @user.update(user_params)
      render Response.data(
        data: @user,
        serializer: V1::Admin::UsersSerializer
      )
    else
      render Response.messaging(
        data: @user.errors.full_messages
      )
    end
  end

  def destroy
    if @user.destroy
      render Response.data(
        data: true
      )
    else
      render Response.data(
        data: @user.errors.full_messages
      )
    end
  end

  private

  def set_user
    @user = User.find_with_id_or_slug(params[:id])
  end

  def user_params
    params.require(User.singular_name)
          .permit(*User::ADMIN_PARAMS[:CHANGEABLE])
  end
end
