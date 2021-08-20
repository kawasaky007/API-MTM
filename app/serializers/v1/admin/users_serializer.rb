# frozen_string_literal: true

class V1::Admin::UsersSerializer < ActiveModel::Serializer
  attributes User::ADMIN_PARAMS[:SHOWABLE].dup
  has_one :photo, serializer: V1::App::PhotosSerializer
end
