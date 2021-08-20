# frozen_string_literal: true

class FlashSale < ApplicationRecord
  include FlashSaleParams

  before_save :init_values

  has_many :flash_sale_details, dependent: :destroy

  validates :active_time,
            :expired_time,
            presence: true

  validate :valid_range_time?

  scope :current_sale, lambda {
    where('expired_time > ? AND popup is false', Time.zone.now).last
  }

  def valid_range_time?
    return if expired_time > active_time

    errors.add(:base, Response::SALE[:VALID_TIME])
  end

  def init_values
    self.slug ||= get_slug_name(:name)
    self.popup ||= false
  end

  def products
    Product
      .joins(:flash_sale_details)
      .where('flash_sale_details.flash_sale_id = ?', id)
  end

  class << self
    def popup
      find_by(
        'popup is true and active_time <= ? and ? <= expired_time',
        *([Time.zone.now] * 2)
      )
    end
  end
end
