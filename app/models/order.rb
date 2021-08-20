# frozen_string_literal: true

class Order < ApplicationRecord
  include OrderParams

  before_save :init_values

  belongs_to :user
  belongs_to :transport, optional: true
  has_many :ordered_products, dependent: :destroy

  enum payment_method: { cod: 'cod', bank: 'bank', momo: 'momo', vnpay: 'vnpay' }
  enum status: { saved: 'saved', ordered: 'ordered', done: 'done' }

  scope :last_or_create, lambda { |condition|
    data = where(condition).last
    data || create(params_object_or_id(:user, condition))
  }
  scope :recent_addresses, lambda {
    all.as_json(only: %i[id address full_name email phone_number province district])
  }

  def init_values
    self.status ||= 'saved'
    self.price ||= 0

    check_transport_method
  end

  def check_transport_method
    transport_status = if province
                         Transport.search(region: province).pluck(:id).include?(transport_id)
                       else
                         false
                       end

    self.transport = Transport.order(price: :desc).first unless transport_status
  end

  def products
    Product.joins(:ordered_products)
           .where('ordered_products.order_id = ?', id)
  end

  # add product to order or update amount
  def add_product(params)
    ordered_product = OrderedProduct.find_or_initialize_by(
      self.class.params_object_or_id(:product, params)
        .merge(order: self)
    )

    if ordered_product.product.pick_out(params[:amount].to_i)
      ordered_product.update(params)
      update_price
    end
    ordered_product
  end

  def remove_product(params)
    ordered_product = OrderedProduct.find_by(
      self.class.params_object_or_id(:product, params)
        .merge(order: self)
    )
    ordered_product&.product&.give_back(ordered_product&.amount)
    ordered_product&.destroy && update_price
  end

  def update_by(_, params)
    if products.empty?
      errors.add(
        :base,
        Response::ORDER[:SAVED_PRODUCTS_EMPTY]
      ); false
    else
      update_price.update(params)
    end
  end

  def update_price
    tap do |obj|
      obj.update(price: cal_price)
    end
  end

  private

  def cal_price
    tmp_price = Product.joins(:ordered_products)
                       .where('ordered_products.order_id = ?', id)
                       .sum('products.price * ordered_products.amount')
    tmp_price + transport.price
  end
end
