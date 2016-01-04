require 'CSV'

namespace :data do
  desc "Import models in our DB."
  #The task is meant to be run after the database has been dropped and recreated
  task :import => :environment do
    customers_path = "#{Rails.root}/lib/assets/customers.csv"
    customer_rows = CSV.readlines(customers_path, headers: true, header_converters: :symbol).map(&:to_h)

    customer_rows.each do |row|
      customer = Customer.create!(row)
      puts "created: #{customer.first_name} #{customer.last_name}"
    end

    index_items_path = "#{Rails.root}/lib/assets/customers.csv"
    index_item_rows = CSV.readlines(index_items_path, headers: true, header_converters: :symbol).map(&:to_h)

    index_item_rows.each do |row|
      index_item = Customer.create!(row)
      puts "created: #{index_item.name}"
    end

    # wrappings_path = "#{Rails.root}/lib/assets/wrappings.yml"
    # wrappings_yml = YAML.load_file(wrappings_path)
    # presents_path = "#{Rails.root}/lib/assets/presents.yml"
    # presents_yml = YAML.load_file(presents_path)

    def populate
      proc do |id, data|
        data["id"] = id
        @klass.create!(data)
        puts "created #{@klass}: #{data['name']}"
      end
    end



    @klass = Customer
    users_yml["users"].each(&populate)
    # @klass = Wrapping
    # wrappings_yml["wrappings"].each(&populate)

    presents_yml["presents"].each do |id, present|
      present["id"] = id
      pres = Present.create!(
                            name: present["name"],
                            price: present["price"],
                            regifted: present["regifted"],
                            receiver: present["receiver"],
                            giver: present["giver"])
  pres.wrappings     << present["wrappingPapers"].values.map {|w| Wrapping.find(w)}
  puts "created: #{pres.name}"
end

  end
end
