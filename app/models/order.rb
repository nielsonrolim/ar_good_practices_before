class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items
  has_many :products, through: :order_items

  enum status: [ :received, :waiting_payment, :in_production, :delivered ]
  enum origin_device: [:unknown, :ios, :android, :web]

  def add_item(product, value)
    self.order_items << OrderItem.create(product: product, value: value)
  end

  def product_names
    self.products.uniq.map(&:name).join(', ')
  end

  def total
    self.order_items.sum(&:value)
  end

  def avg_value
    self.total / self.order_items.size
  end

end
