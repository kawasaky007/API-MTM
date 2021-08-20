# frozen_string_literal: true

class Banner < ApplicationRecord
  include BannerParams

  before_save :init_values

  validates :url, presence: true

  def init_values
    self.slug ||= get_slug_name(:name)
  end
end
