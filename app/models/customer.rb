class Customer < ActiveRecord::Base
  default_scope -> { order('id DESC') }

  has_many :invoices
  has_many :transactions, through: :invoices

  def favorite_merchant
    merchant_id = self.invoices
                      .successful
                      .unscope(:order)
                      .group(:merchant_id)
                      .count
                      .max_by { |key, value| value }.first
                      
    Merchant.find(merchant_id)
  end

end
