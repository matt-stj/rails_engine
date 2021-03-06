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
    { revenue: invoices.successful.joins(:invoice_items).where(created_at: date).sum("quantity * unit_price") }
  end

  def self.total_revenue_for_date(date)
    { total_revenue: Invoice.has_merchant.successful.joins(:invoice_items).where(created_at: date).sum("quantity * unit_price") }
  end

  def customers_with_pending_invoices
    outstanding_customers = []
    self.invoices.pending.map do |invoice|
      outstanding_customers << invoice.customer
    end
    outstanding_customers.uniq
  end

  def favorite_customer
      customer_id = self.invoices
                        .successful
                        .unscope(:order)
                        .group(:customer_id)
                        .count
                        .max_by { |key, value| value }.first

      Customer.find(customer_id)
  end

  def self.most_revenue(quantity)
    all.sort_by(&:merchant_revenue).reverse.first(quantity.to_i)
  end

  def merchant_revenue
    invoices.successful.joins(:invoice_items).sum("quantity * unit_price")
  end

end
