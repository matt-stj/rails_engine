class Invoice < ActiveRecord::Base
  belongs_to :merchant
  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items

  default_scope -> { order('id DESC') }

  def self.successful
    joins(:transactions).merge(Transaction.success)
  end

  def self.pending
    joins(:transactions).merge(Transaction.failed)
  end

end
