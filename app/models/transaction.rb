class Transaction < ActiveRecord::Base
  belongs_to :invoice

  default_scope -> { order('id DESC') }

  def self.success
    self.where("result = 'success'")
  end

  def self.failed
    self.where("result = 'failed'")
  end

end
