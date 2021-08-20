# frozen_string_literal: true

class FlashSaleDetail < ApplicationRecord
  belongs_to :product
  belongs_to :flash_sale, optional: true

  after_initialize :init_values

  validates :limit_per_user,
            :total,
            :product_id,
            :discount,
            presence: true

  def init_values
    self.active ||= true
  end
end
