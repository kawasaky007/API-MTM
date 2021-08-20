# frozen_string_literal: true

class V1::App::UsersSerializer < ActiveModel::Serializer
  attributes User::USER_PARAMS[:SHOWABLE].dup
  has_one :photo, serializer: V1::App::PhotosSerializer
end
