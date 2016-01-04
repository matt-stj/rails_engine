class CreateInvoiceItems < ActiveRecord::Migration
  def change
    create_table :invoice_items do |t|
      t.integer :item_id
      t.string :invoice_id
      t.string :integer
      t.integer :quantity
      t.integer :unit_price

      t.timestamps null: false
    end
  end
end
