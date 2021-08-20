# frozen_string_literal: true

class Category < ApplicationRecord
  include CategoryParams
  include Helpers::CrawlingHelper

  before_save :init_values

  belongs_to :parent, class_name: 'Category', optional: true
  has_many :category_linkers, dependent: :destroy
  has_many :children,
           class_name: 'Category',
           foreign_key: 'parent_id',
           dependent: :destroy,
           inverse_of: :parent
  accepts_nested_attributes_for :children

  validates :name, presence: true

  scope :only_parents, -> { where(parent_id: nil) }
  scope :combo_tiet_kiem, -> { search(name: 'Combo tiết kiệm') }
  scope :hot_categories, -> { where(showable: true) }
  # ranking cate and show it into standard cate in home page
  scope :home_page, lambda {
    # list cates have amount of product in order
    where(independent_brand: true)
  }
  scope :products, lambda {
    Product
      .joins(:category_linkers)
      .where('category_linkers.category_id in (?)', pluck(:id))
  }

  def init_values
    self.icon ||= CONST::DEFAULT_ICON
    self.photo ||= CONST::DEFAULT_PRODUCT_IMAGE
    self.color ||= Helpers::RandomHelper.color
    self.slug ||= get_slug_name(:name)
    self.showable ||= false
    self.independent_brand ||= false
  end

  def create_product(params)
    CategoryLinker.create(
      category: self,
      product: Product.create(params)
    )
  end

  def products
    Product
      .joins(:category_linkers)
      .where('category_linkers.category_id = ?', id)
  end

  def import_from_url(url = self.url)
    return if url.nil?

    get_products(get_content(url)).each do |product|
      create_product(product)
    end
  rescue StandardError => e
    logger.info "FAILD: AT #{url} #{e}"
  end

  def list_brands
    params = [id]
    params << parent_id unless parent_id.nil?

    self.class.brands.where(
      'parent_id in (?)',
      params
    )
  end

  class << self
    def brands
      where(independent_brand: true)
    end
  end
end
