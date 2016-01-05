class InvoiceItem < ActiveRecord::Base
  default_scope -> { order('id DESC') }
  before_create :convert_cents

  belongs_to :invoice
  belongs_to :item

  def convert_cents
    self.unit_price = (unit_price/100).to_f
  end
end
