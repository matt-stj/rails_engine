class InvoiceItem < ActiveRecord::Base
  default_scope -> { order('id DESC') }
  before_create :convert_cents

  def convert_cents
    self.unit_price = (unit_price/100).to_f
  end
end
