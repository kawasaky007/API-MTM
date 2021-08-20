# frozen_string_literal: true

class Admin < ApplicationRecord
  has_secure_password

  before_save :default_values

  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :email, uniqueness: true
  validates :full_name,
            :password_digest,
            :email, presence: true

  def default_values
    self.auth_code ||= Crypto.generate_code
    self.active ||= true
  end

  class << self
    def generate_new_code(user)
      user.tap do |u|
        u.auth_code = Crypto.generate_code
      end
    end
  end
end
