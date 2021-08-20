# frozen_string_literal: true

class Photo < ApplicationRecord
  belongs_to :photoable, polymorphic: true
end
