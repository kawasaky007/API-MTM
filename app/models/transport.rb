# frozen_string_literal: true

class Transport < ApplicationRecord
  include TransportParams

  before_save :init_values

  validates :name,
            :region,
            :transport_method,
            :price,
            presence: true

  def init_values
    self.name ||= ''
    self.price ||= 0
    self.region ||= ''
    self.transport_method ||= ''
  end
end
