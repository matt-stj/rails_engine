class Item < ActiveRecord::Base
  default_scope -> { order('id DESC') }

  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  def best_day
    
  end
end
