class Invoice < ActiveRecord::Base
  default_scope -> { order('id DESC') }

  belongs_to :merchant
end
