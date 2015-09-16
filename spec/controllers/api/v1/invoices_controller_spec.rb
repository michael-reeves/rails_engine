require 'rails_helper'

describe Api::V1::InvoicesController do
  let!(:customer) { Customer.create!(first_name: "Jane", last_name: "Doe")}
  let!(:merchant) { Merchant.create!(name:"Store 1") }

  let!(:invoice1) { Invoice.create!(status:      "ordered",
                                    customer_id: customer.id,
                                    merchant_id: merchant.id)
                  }
  let!(:invoice2) { Invoice.create!(status:      "shipped",
                                    customer_id: customer.id,
                                    merchant_id: merchant.id)
                  }

  let!(:invoice3) { Invoice.create!(status:      "shipped",
                                    customer_id: customer.id,
                                    merchant_id: merchant.id)
                  }

  describe 'GET #index' do
    it 'populates an array of Invoices' do
      get :index, format: :json

      invoices = JSON.parse(response.body, symbolize_names: true)
      invoice  = invoices.first

      expect(response).to              be_success
      expect(invoices.count).to        eq 3
      expect(invoice[:status]).to      eq 'ordered'
      expect(invoice[:customer_id]).to eq 1
      expect(invoice[:merchant_id]).to eq 1
    end
  end

  describe 'GET #show' do
    it 'returns an Invoice' do
      get :show, format: :json, id: invoice1.id

      invoice = JSON.parse(response.body, symbolize_names: true)

      expect(response).to              be_success
      expect(invoice[:status]).to      eq 'ordered'
      expect(invoice[:customer_id]).to eq 1
      expect(invoice[:merchant_id]).to eq 1
    end
  end

  describe 'GET #find' do
    it 'finds an Invoice by id' do
      get :find, format: :json, id: invoice1.id

      invoice = JSON.parse(response.body, symbolize_names: true)

      expect(response).to              be_success
      expect(invoice[:status]).to      eq 'ordered'
      expect(invoice[:customer_id]).to eq 1
      expect(invoice[:merchant_id]).to eq 1
    end

    it 'finds an Invoice by status' do
      get :find, format: :json, status: invoice1.status

      invoice = JSON.parse(response.body, symbolize_names: true)

      expect(response).to              be_success
      expect(invoice[:status]).to      eq 'ordered'
      expect(invoice[:customer_id]).to eq 1
      expect(invoice[:merchant_id]).to eq 1
    end

    it 'finds an Invoice by customer_id' do
      get :find, format: :json, customer_id: invoice1.customer_id

      invoice = JSON.parse(response.body, symbolize_names: true)

      expect(response).to              be_success
      expect(invoice[:status]).to      eq 'shipped'
      expect(invoice[:customer_id]).to eq 1
      expect(invoice[:merchant_id]).to eq 1
    end

    it 'finds an Invoice by merchant_id' do
      get :find, format: :json, merchant_id: invoice1.merchant_id

      invoice = JSON.parse(response.body, symbolize_names: true)

      expect(response).to              be_success
      expect(invoice[:status]).to      eq 'shipped'
      expect(invoice[:customer_id]).to eq 1
      expect(invoice[:merchant_id]).to eq 1
    end
  end

  describe 'GET #find_all' do
    it 'finds all Invoices by id' do
      get :find_all, format: :json, id: invoice1.id

      invoices = JSON.parse(response.body, symbolize_names: true)
      invoice  = invoices.first

      expect(response).to              be_success
      expect(invoices.count).to        eq 1
      expect(invoice[:status]).to      eq 'ordered'
      expect(invoice[:customer_id]).to eq 1
      expect(invoice[:merchant_id]).to eq 1
    end

    it 'finds all Invoices by status' do
      get :find_all, format: :json, status: invoice1.status

      invoices = JSON.parse(response.body, symbolize_names: true)
      invoice  = invoices.first

      expect(response).to              be_success
      expect(invoices.count).to        eq 1
      expect(invoice[:status]).to      eq 'ordered'
      expect(invoice[:customer_id]).to eq 1
      expect(invoice[:merchant_id]).to eq 1
    end

    it 'finds all Invoices by customer_id' do
      get :find_all, format: :json, customer_id: invoice1.customer_id

      invoices = JSON.parse(response.body, symbolize_names: true)
      invoice  = invoices.first

      expect(response).to              be_success
      expect(invoices.count).to        eq 3
      expect(invoice[:status]).to      eq 'ordered'
      expect(invoice[:customer_id]).to eq 1
      expect(invoice[:merchant_id]).to eq 1
    end

    it 'finds all Invoices by merchant_id' do
      get :find_all, format: :json, merchant_id: invoice1.merchant_id

      invoices = JSON.parse(response.body, symbolize_names: true)
      invoice  = invoices.first

      expect(response).to              be_success
      expect(invoices.count).to        eq 3
      expect(invoice[:status]).to      eq 'ordered'
      expect(invoice[:customer_id]).to eq 1
      expect(invoice[:merchant_id]).to eq 1
    end
  end

  describe 'GET #random' do
    it 'returns a random Invoice' do
      get :random, format: :json

      invoice = JSON.parse(response.body, symbolize_names: true)

      expect(response).to                  be_success
      expect(invoice[:id]).not_to          be_nil
      expect(invoice[:status]).not_to      be_nil
      expect(invoice[:customer_id]).not_to be_nil
      expect(invoice[:merchant_id]).not_to be_nil
    end
  end

  describe 'GET #transactions' do
    it 'returns an array of transactions for the invoice' do
      merchant = Merchant.create(name: 'Stark')
      customer = Customer.create!(first_name: "Jon",  last_name: "Snow")

      invoice = Invoice.create(merchant_id: merchant.id,
                               customer_id: customer.id, status: 'ordered')

      transaction1 = invoice.transactions.create(
                                      credit_card_number: "4321876554329876",
                                      result: 'failed')
      transaction1 = invoice.transactions.create(
                                      credit_card_number: "4333476554329876",
                                      result: 'failed')
      transaction2 = invoice.transactions.create(
                                      credit_card_number: "4561876554321234",
                                      result: 'success')

      get :transactions, format: :json, invoice_id: invoice.id

      transactions = JSON.parse(response.body, symbolize_names: true)
      transaction  = transactions.last

      expect(response).to                         be_success
      expect(transactions.count).to               eq 3
      expect(transaction[:id]).to                 eq 3
      expect(transaction[:result]).to             eq "success"
      expect(transaction[:credit_card_number]).to eq "4561876554321234"
    end
  end

  describe 'GET #invoice_items' do
    it 'returns an array of invoice_items for the invoice' do
      merchant = Merchant.create(name: 'Stark')
      customer = Customer.create!(first_name: "Jon",  last_name: "Snow")

      invoice = Invoice.create(merchant_id: merchant.id,
                               customer_id: customer.id, status: 'ordered')

      item1 = Item.create(name:        "First item",
                          description: "First description",
                          unit_price:  399,
                          merchant_id: merchant.id)
      item2 = Item.create(name:        "Second item",
                          description: "Second description",
                          unit_price:  199,
                          merchant_id: merchant.id)
      invoice_item1 = invoice.invoice_items.create(item_id: item1.id,
                                                   quantity: 4,
                                                   unit_price: item1.unit_price)
      invoice_item2 = invoice.invoice_items.create(item_id:    item2.id,
                                                   quantity:   10,
                                                   unit_price: item2.unit_price)

      get :invoice_items, format: :json, invoice_id: invoice.id

      invoice_items = JSON.parse(response.body, symbolize_names: true)
      invoice_item  = invoice_items.first

      expect(response).to                  be_success
      expect(invoice_items.count).to       eq 2
      expect(invoice_item[:id]).to         eq 1
      expect(invoice_item[:quantity]).to   eq 4
      expect(invoice_item[:unit_price]).to eq "399.0"
    end
  end

  describe 'GET #items' do
    it 'returns an array of items for the invoice' do
      merchant = Merchant.create(name: 'Stark')
      customer = Customer.create!(first_name: "Jon",  last_name: "Snow")

      invoice = Invoice.create(merchant_id: merchant.id,
                               customer_id: customer.id, status: 'ordered')

      item1 = Item.create(name:        "First item",
                          description: "First description",
                          unit_price:  399,
                          merchant_id: merchant.id)
      item2 = Item.create(name:        "Second item",
                          description: "Second description",
                          unit_price:  199,
                          merchant_id: merchant.id)
      invoice_item1 = invoice.invoice_items.create(item_id: item1.id,
                                                   quantity: 4,
                                                   unit_price: item1.unit_price)
      invoice_item2 = invoice.invoice_items.create(item_id:    item2.id,
                                                   quantity:   10,
                                                   unit_price: item2.unit_price)

      get :items, format: :json, invoice_id: invoice.id

      items = JSON.parse(response.body, symbolize_names: true)
      item  = items.first

      expect(response).to           be_success
      expect(items.count).to        eq 2
      expect(item[:id]).to          eq 1
      expect(item[:name]).to        eq "First item"
      expect(item[:description]).to eq "First description"
      expect(item[:unit_price]).to  eq "399.0"
    end
  end

  describe 'GET #customer' do
    it 'returns the customer for the invoice' do
      merchant = Merchant.create(name: 'Stark')
      customer = Customer.create!(first_name: "Jon",  last_name: "Snow")

      invoice = Invoice.create(merchant_id: merchant.id,
                               customer_id: customer.id, status: 'ordered')

      get :customer, format: :json, invoice_id: invoice.id

      customer = JSON.parse(response.body, symbolize_names: true)

      expect(response).to              be_success
      expect(customer[:id]).to         eq 2
      expect(customer[:first_name]).to eq "Jon"
      expect(customer[:last_name]).to  eq "Snow"
    end
  end

  describe 'GET #merchant' do
    it 'returns the merchant for the invoice' do
      merchant = Merchant.create(name: 'Stark')
      customer = Customer.create!(first_name: "Jon",  last_name: "Snow")

      invoice = Invoice.create(merchant_id: merchant.id,
                               customer_id: customer.id, status: 'ordered')

      get :merchant, format: :json, invoice_id: invoice.id

      merchant = JSON.parse(response.body, symbolize_names: true)

      expect(response).to              be_success
      expect(merchant[:id]).to         eq 2
      expect(merchant[:name]).to eq "Stark"
    end
  end
end
