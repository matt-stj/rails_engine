class Merchant < ActiveRecord::Base
  default_scope -> { order('id DESC') }

  has_many :items
  has_many :invoices
  has_many :invoice_items, through: :invoices
  has_many :transactions, through: :invoices

  def revenue
    { revenue: invoices.successful.joins(:invoice_items).sum("quantity * unit_price") }
  end

end
