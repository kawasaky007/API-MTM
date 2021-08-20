# frozen_string_literal: true

module Helpers::CrawlingHelper
  extend ActiveSupport::Concern

  def get_content(url)
    url = URI(url)

    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true

    request = Net::HTTP::Get.new(url)

    response = https.request(request)
    response.read_body.force_encoding(Encoding::UTF_8)
  end

  def get_products(page)
    results = []
    page.scan(/<div class="product-image image-resize">[^.]*<a href="([^"]+)"/) do |result|
      # results << "https://methongminh.com.vn#{result.first}"
      results << get_details_product("https://methongminh.com.vn#{result.first}")
    end
    results
  end

  def get_details_product(url)
    page = get_content(url)

    name = page.scan(/<div class="product-title">[\n\s]*<h1>([^<>]*)<.h1>[\n\s]*<.div>/).first.first
    photos_attributes = []
    page.scan(/data-image="([^"]+)"/) do |result|
      photos_attributes << { url: "https:#{result[0]}" }
    end

    price = [
      page.scan(/<span>([\d,]+₫)<.span>/).first.first.to_i * 1000 + 0.0,
      page.scan(/<del>([\d,]+₫)<.del>/)&.first&.first.to_i * 1000 + 0.0
    ].sort
    discount = (price.first / price.last).round(2)
    price = price.filter(&:nonzero?).first

    details = page.scan(/<div id="description">([^😎]+)<div id="comment"/).first.first
    {
      name: name,
      photos_attributes: photos_attributes,
      price: price,
      discount: discount,
      details: details,
      url: url,
      status: 'on_sell'
    }
  end
end
