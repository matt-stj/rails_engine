class Merchant < ActiveRecord::Base
  default_scope -> { order('id DESC') }

  has_many :items
  has_many :invoices
  has_many :invoice_items, through: :invoices
  has_many :transactions, through: :invoices

  def revenue
    { revenue: invoices.successful.joins(:invoice_items).sum("quantity * unit_price") }
  end

  def revenue_with_date(date)
    { revenue: invoices.unscoped.successful.joins(:invoice_items).where(created_at: date).sum("quantity * unit_price") }
  end

  def customers_with_pending_invoices
    outstanding_customers = []
    self.invoices.pending.map do |invoice|
      outstanding_customers << invoice.customer
    end
    outstanding_customers.uniq
  end

end
