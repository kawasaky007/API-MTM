# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password
  include UserParams

  before_save :default_values
  before_save :dependency

  has_many :orders, dependent: :destroy
  has_one :photo, as: :photoable, dependent: :destroy
  accepts_nested_attributes_for :photo

  validates :phone_number, format: { with: CONST::PHONE_NUMBER_REGEX_VALIDATE }
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :email,
            :phone_number,
            uniqueness: true
  validates :full_name,
            :password_digest,
            :phone_number,
            :email, presence: true

  enum sex: { male: 'male', female: 'female', unknow_sex: 'unknow_sex' }

  def default_values
    self.auth_code ||= Crypto.generate_code
    self.resgistation_activated ||= false
    self.sex ||= 'unknow_sex'
    self.active ||= true
  end

  def update_new_password(args)
    if args[:current_password] == args[:new_password]
      raise ActiveRecord::QueryCanceled,
            Response::USER[:SAME_OLD_P]
    elsif !authenticate(args[:current_password])
      raise ActiveRecord::QueryCanceled,
            Response::USER[:WRG_PASSWORD]
    end
    update(password: args[:new_password])
  end

  def update_password(args)
    return update(password: args[:new_password]) unless authenticate(args[:new_password])

    raise ActiveRecord::QueryCanceled,
          Response::USER[:SAME_OLD_P]
  end

  def dependency
    self.photo_attributes = { url: CONST::DEFAULT_PRODUCT_IMAGE } if photo.nil?
  end

  def photo_attributes=(*args)
    photo&.destroy

    super(*args)
  end

  def current_saved
    Order.last_or_create(
      user: self,
      status: 'saved'
    )
  end

  def current_ordered
    Order.find_by(
      user: self,
      status: 'ordered'
    )
  end

  class << self
    def generate_new_code(user)
      user.tap do |u|
        u.auth_code = Crypto.generate_code
      end
    end
  end
end
