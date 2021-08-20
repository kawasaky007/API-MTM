# frozen_string_literal: true

class V1::App::UsersController < AppController
  before_action :authorize_request

  def show_profile
    render Response.data(
      data: @current_user,
      serializer: V1::App::UsersSerializer
    )
  end

  def forget_password
    if @current_user.update_password(new_password: params[:new_password])
      render Response.data(
        data: { token: Crypto.generate_token(@current_user) }
      )
    else
      render Response.messaging(
        data: @current_user.errors.full_messages
      )
    end
  end

  def update_password
    if @current_user.update_password(current_password: params[:current_password],
                                     new_password: params[:new_password])
      render Response.data(
        data: { token: Crypto.generate_token(@current_user) }
      )
    else
      render Response.messaging(
        data: @current_user.errors.full_messages
      )
    end
  end

  def update_profile
    if @current_user.update(app_user_params)
      render Response.data(
        data: @current_user,
        serializer: V1::App::UsersSerializer
      )
    else
      render Response.messaging(
        data: @current_user.errors.full_messages
      )
    end
  end

  def destroy
    @current_user.destroy
    if @current_user.destroy
      render Response.success
    else
      render Response.messaging(
        data: @current_user.errors.full_messages
      )
    end
  end

  private

  def app_user_params
    params.require(User.singular_name)
          .permit(*User::USER_PARAMS[:CHANGEABLE])
  end
end
