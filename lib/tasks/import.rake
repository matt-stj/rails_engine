require 'CSV'

namespace :data do
  desc "Import models into our DB."
  #The task is meant to be run after the database has been dropped and recreated
  task :import => :environment do
    # Import Customers
    customers_path = "#{Rails.root}/lib/assets/customers.csv"
    customer_rows = CSV.readlines(customers_path, headers: true, header_converters: :symbol).map(&:to_h)

    customer_rows.each do |row|
      customer = Customer.create!(row)
      puts "created customer: #{customer.first_name} #{customer.last_name}"
    end

    # Import Merchants
    merchants_path = "#{Rails.root}/lib/assets/merchants.csv"
    merchant_rows = CSV.readlines(merchants_path, headers: true, header_converters: :symbol).map(&:to_h)

    merchant_rows.each do |row|
      merchant = Merchant.create!(row)
      puts "created merchant: #{merchant.name}"
    end

    # Import Items
    items_path = "#{Rails.root}/lib/assets/items.csv"
    item_rows = CSV.readlines(items_path, headers: true, header_converters: :symbol).map(&:to_h)

    item_rows.each do |row|
      item = Item.create!(row)
      puts "created item: #{item.name}"
    end

    #Import Transactions
    transactions_path = "#{Rails.root}/lib/assets/transactions.csv"
    transaction_rows = CSV.readlines(transactions_path, headers: true, header_converters: :symbol).map(&:to_h)

    transaction_rows.each do |row|
      transaction = Transaction.create!(id: row[:id],
                                        invoice_id: row[:invoice_id],
                                        credit_card_number: row[:credit_card_number],
                                        result: row[:result],
                                        created_at: row[:created_at],
                                        updated_at: row[:updated_at])
      puts "created transaction: #{transaction.id}"
    end

    #import Invoices
    invoices_path = "#{Rails.root}/lib/assets/invoices.csv"
    invoice_rows = CSV.readlines(invoices_path, headers: true, header_converters: :symbol).map(&:to_h)

    invoice_rows.each do |row|
      invoice = Invoice.create!(row)
      puts "created invoice: #{invoice.id}"
    end

    #Import Invoice_Items
    invoice_items_path = "#{Rails.root}/lib/assets/invoice_items.csv"
    invoice_item_rows = CSV.readlines(invoice_items_path, headers: true, header_converters: :symbol).map(&:to_h)

    invoice_item_rows.each do |row|
      invoice_item = InvoiceItem.create!(row)
      puts "created Invoice Item #: #{invoice_item.id}"
    end

  end
end
