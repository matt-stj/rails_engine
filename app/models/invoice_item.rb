class InvoiceItem < ActiveRecord::Base
  default_scope -> { order('id DESC') }

  belongs_to :invoice
  belongs_to :item
end
