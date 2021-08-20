# frozen_string_literal: true

class CategoryLinker < ApplicationRecord
  belongs_to :category
  belongs_to :product
end
