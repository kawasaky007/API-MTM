# frozen_string_literal: true

module Helpers::SerializerHelpers
  def self.each(*args)
    serializer = args.second[:each_serializer].new(
      nil,
      args.second.except(:each_serializer)
    )
    args.first.map do |item|
      serializer.tap do |seri|
        seri.object = item
      end.to_h
    end
  end

  class << self
    def num_format(string:, num:, char:)
      {
        string: "#{string}#{char}",
        num: num.to_f
      }
    end
  end
end
