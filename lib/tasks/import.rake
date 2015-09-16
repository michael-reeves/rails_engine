require 'csv'

namespace :db do
  desc "Import database from CSV files"
  task import: [:environment] do
    customers     = "db/data/customers.csv"
    merchants     = "db/data/merchants.csv"
    items         = "db/data/items.csv"
    invoices      = "db/data/invoices.csv"
    invoice_items = "db/data/invoice_items.csv"
    transactions  = "db/data/transactions.csv"

    CSV.foreach(customers, headers: true, header_converters: :symbol) do |record|
      customer = Customer.create!( record.to_hash )
                # {
                #    first_name: record[:first_name],
                #    last_name:  record[:last_name],
                #    created_at: record[:created_at],
                #    updated_at: record[:updated_at]
                #  })
      # puts "Customer: #{customer.id} created"
    end
    puts "Customers created"

    CSV.foreach(merchants, headers: true, header_converters: :symbol) do |record|
      merchant = Merchant.create!( record.to_hash )
                # {
                #    name:       record[:name],
                #    created_at: record[:created_at],
                #    updated_at: record[:updated_at]
                #  })
      # puts "Merchant: #{merchant.id} created"
    end
    puts "Merchants created"

    CSV.foreach(items, headers: true, header_converters: :symbol) do |record|
      item = Item.create!({
               id:          record[:id],
               name:        record[:name],
               description: record[:description],
               unit_price:  record[:unit_price].to_f / 100,
               merchant_id: record[:merchant_id],
               created_at:  record[:created_at],
               updated_at:  record[:updated_at]
             })
      # puts "Item: #{item.id} created"
    end
    puts "Items created"

    CSV.foreach(invoices, headers: true, header_converters: :symbol) do |record|
      invoice = Invoice.create!(record.to_hash)
        # id:                 record[:id],
        #           customer_id: record[:customer_id],
        #           merchant_id: record[:merchant_id],
        #           status:      record[:status],
        #           created_at:  record[:created_at],
        #           updated_at:  record[:updated_at]
        #         })
      # puts "Invoice: #{invoice.id} created"
    end
    puts "Invoices created"

    CSV.foreach(invoice_items, headers: true, header_converters: :symbol) do |record|
      invoice_item = InvoiceItem.create!({
                       id:         record[:id],
                       item_id:    record[:item_id],
                       invoice_id: record[:invoice_id],
                       quantity:   record[:quantity],
                       unit_price: record[:unit_price].to_f / 100,
                       created_at: record[:created_at],
                       updated_at: record[:updated_at]
                     })
      # puts "Invoice_Item: #{invoice_item.id} created"
    end
    puts "Invoice_Items created"

    CSV.foreach(transactions, headers: true, header_converters: :symbol) do |record|
      transaction = Transaction.create!({
                      id:                 record[:id],
                      invoice_id:         record[:invoice_id],
                      credit_card_number: record[:credit_card_number],
                      result:             record[:result],
                      created_at:         record[:created_at],
                      updated_at:         record[:updated_at]
                    })
      # puts "Transaction: #{transaction.id} created"
    end
    puts "Transactions created"
  end
end
