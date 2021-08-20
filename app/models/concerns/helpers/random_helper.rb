# frozen_string_literal: true

module Helpers::RandomHelper
  def self.string
    rand(36**8).to_s(36)
  end

  def self.unique_code(model, attribute)
    loop do
      code = string.upcase
      return code if model.find_by(attribute => code).blank?
    end
  end

  def self.color
    format('#%06x', rand * 0xffffff)
  end
end
