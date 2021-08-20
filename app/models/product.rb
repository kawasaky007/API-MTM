# frozen_string_literal: true

class Product < ApplicationRecord
  include ProductParams

  before_save :init_values
  before_save :dependency

  has_many :category_linkers, dependent: :destroy
  has_many :flash_sale_details, dependent: :destroy
  has_many :ordered_products, dependent: :destroy
  has_many :photos, as: :photoable, dependent: :destroy
  accepts_nested_attributes_for :photos

  validates :amount, numericality: {
    greater_than_or_equal_to: CONST::PRODUCT_IN_STOCK
  }
  validates :name,
            :price,
            presence: true

  enum status: { on_sell: 'on_sell', in_stock: 'in_stock' }

  # Init value and dependencies of product
  def init_values
    self.status ||= 'in_stock'
    self.code ||= Helpers::RandomHelper.unique_code(Product, :code)
    self.url ||= '/'
    self.discount ||= 0.0
    self.details ||= ''
    self.amount ||= CONST::DEFAULT_PRODUCT_AMOUNT
    self.slug ||= get_slug_name(:name)
  end

  def dependency
    self.photos_attributes = [{ url: CONST::DEFAULT_PRODUCT_IMAGE }] if photos.empty?
  end

  def photos_attributes=(*args)
    photos.clear
    super(*args)
  end

  # Order actions pick product to order or remove product from order
  def pick_out(amnt)
    if amount - amnt > CONST::PRODUCT_IN_STOCK && on_sell?
      update(amount: amount - amnt)
    else
      errors.add(
        :base,
        Response::PRODUCT[:PRODUCT_IN_STOCK]
      ); false
    end
  end

  def give_back(amnt)
    on_sell! if amount + amnt > CONST::PRODUCT_IN_STOCK
    update(amount: amount + amnt)
  end

  # Utils Function for serializers and related models
  def on_saling?
    return false if flash_sale_detail_id.nil?

    !FlashSaleDetail.find_by(id: flash_sale_detail_id).nil?
  end

  def create_current_flash_sale_detail(params)
    fl = FlashSaleDetail.create(
      params.merge(
        product: self
      )
    )
    update(flash_sale_detail_id: fl.id)
  end

  def last_flash_sale_detail
    FlashSaleDetail.find_by(id: flash_sale_detail_id) if on_saling?
  end

  def price_after_discount
    on_saling? ? (price + 0.0) * (1 - discount) : price
  end

  def discount_with_sale
    return 0 unless on_saling?

    last_flash_sale_detail.discount
  end

  def categories
    Category.where(
      'id in (?)',
      category_linkers.pluck(:category_id)
    )
  end

  def related_projects
    category_linker_ids = category_linkers.pluck(:category_id)
    Product
      .joins(:category_linkers)
      .where('category_linkers.category_id in (?)', category_linker_ids)
      .limit(CONST::DEFAULT_RELATED_PROJECTS)
      .randomly!
  end

  def selled_amount
    OrderedProduct.where(product: self).sum(:amount)
  end

  class << self
    def categories_filter(*args)
      return all if args.blank? || args == [nil]

      joins(:category_linkers)
        .where('category_linkers.category_id in (?)', args)
    end

    def search(args)
      records = super(args.except(:price))
      return records if args[:price].nil?

      records.where(
        '? <= price AND price <= ?',
        *args[:price].split(',').map(&:to_f)
      )
    end
  end
end
