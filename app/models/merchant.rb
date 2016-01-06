class Merchant < ActiveRecord::Base
  default_scope -> { order('id DESC') }

  has_many :items
  has_many :invoices
  has_many :invoice_items, through: :invoices
  has_many :transactions, through: :invoices

end
