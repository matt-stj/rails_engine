class Item < ActiveRecord::Base
  default_scope -> { order('id DESC') }

  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  def calculate_revenue
   invoices.successful.joins(:invoice_items).sum("invoice_items.quantity * invoice_items.unit_price")
  end

  def self.most_revenue_items(quantity)
    all.sort_by(&:calculate_revenue).reverse.first(quantity.to_i)
  end

end
