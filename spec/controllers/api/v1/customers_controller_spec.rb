require 'rails_helper'

describe Api::V1::CustomersController do
  let!(:customer1) { Customer.create!(first_name: "Jon",   last_name: "Snow") }
  let!(:customer2) { Customer.create!(first_name: "Arya",  last_name: "Stark") }
  let!(:customer3) { Customer.create!(first_name: "Loras", last_name: "Tyrell") }
  let!(:customer4) { Customer.create!(first_name: "The",   last_name: "Hound") }

  describe 'GET #index' do
    it 'populates an array of Customers' do
      get :index, format: :json

      customers = JSON.parse(response.body, symbolize_names: true)
      customer  = customers.first

      expect(response).to              be_success
      expect(customers.count).to       eq 4
      expect(customer[:first_name]).to eq 'Jon'
      expect(customer[:last_name]).to  eq 'Snow'
    end
  end

  describe 'GET #show' do
    it 'returns a Customer' do
      get :show, format: :json, id: customer3.id

      customer = JSON.parse(response.body, symbolize_names: true)

      expect(response).to              be_success
      expect(customer[:first_name]).to eq 'Loras'
      expect(customer[:last_name]).to  eq 'Tyrell'
    end
  end

  describe 'GET #find' do
    it 'finds a Customer by id' do
      get :find, format: :json, id: customer4.id

      customer = JSON.parse(response.body, symbolize_names: true)

      expect(response).to              be_success
      expect(customer[:first_name]).to eq 'The'
      expect(customer[:last_name]).to  eq 'Hound'
    end

    it 'finds a Customer by first_name' do
      get :find, format: :json, first_name: customer2.first_name

      customer = JSON.parse(response.body, symbolize_names: true)

      expect(response).to              be_success
      expect(customer[:first_name]).to eq 'Arya'
      expect(customer[:last_name]).to  eq 'Stark'
    end

    it 'finds a Customer by last_name' do
      get :find, format: :json, last_name: customer3.last_name

      customer = JSON.parse(response.body, symbolize_names: true)

      expect(response).to              be_success
      expect(customer[:first_name]).to eq 'Loras'
      expect(customer[:last_name]).to  eq 'Tyrell'
    end
  end

  describe 'GET #find_all' do
    it 'finds all Customers by id' do
      get :find_all, format: :json, id: customer1.id

      customers = JSON.parse(response.body, symbolize_names: true)
      customer  = customers.first

      expect(response).to              be_success
      expect(customers.count).to       eq 1
      expect(customer[:first_name]).to eq 'Jon'
      expect(customer[:last_name]).to  eq 'Snow'
    end

    it 'finds all Customers by first_name' do
      get :find_all, format: :json, first_name: customer2.first_name

      customers = JSON.parse(response.body, symbolize_names: true)
      customer  = customers.first

      expect(response).to              be_success
      expect(customers.count).to       eq 1
      expect(customer[:first_name]).to eq 'Arya'
      expect(customer[:last_name]).to  eq 'Stark'
    end

    it 'finds all Customers by last_name' do
      get :find_all, format: :json, last_name: customer3.last_name

      customers = JSON.parse(response.body, symbolize_names: true)
      customer  = customers.first

      expect(response).to              be_success
      expect(customers.count).to       eq 1
      expect(customer[:first_name]).to eq 'Loras'
      expect(customer[:last_name]).to  eq 'Tyrell'
    end
  end

  describe 'GET #random' do
    it 'returns a random Customer' do
      get :random, format: :json

      customer = JSON.parse(response.body, symbolize_names: true)

      expect(response).to                  be_success
      expect(customer[:id]).not_to         be_nil
      expect(customer[:first_name]).not_to be_nil
      expect(customer[:last_name]).not_to  be_nil
    end
  end

  describe 'GET #invoices' do
    it "returns an array of customer invoices" do
      merchant1 = Merchant.create(name: 'Stark')
      merchant2 = Merchant.create(name: 'Lannister')

      invoice1 = Invoice.create(merchant_id: merchant1.id,
                                customer_id: customer1.id, status: 'ordered')
      invoice2 = Invoice.create(merchant_id: merchant2.id,
                                customer_id: customer1.id, status: 'shipped')
      invoice3 = Invoice.create(merchant_id: merchant1.id,
                                customer_id: customer2.id, status: 'ordered')

      get :invoices, format: :json, customer_id: customer1.id

      invoices = JSON.parse(response.body, symbolize_names: true)
      invoice  = invoices.first

      expect(response).to            be_success
      expect(invoices.count).to eq 2
      expect(invoice[:id]).to eq 1
      expect(invoice[:merchant_id]).to eq 1
    end
  end

  describe 'GET #transactions' do
    it "returns an array of customer transactions" do
      merchant1 = Merchant.create(name: 'Stark')
      merchant2 = Merchant.create(name: 'Lannister')

      invoice1 = Invoice.create(merchant_id: merchant1.id,
                                customer_id: customer1.id, status: 'ordered')
      invoice2 = Invoice.create(merchant_id: merchant2.id,
                                customer_id: customer1.id, status: 'shipped')

      transaction1 = invoice1.transactions.create(
                                      credit_card_number: "4321876554329876",
                                      result: 'failed')
      transaction2 = invoice1.transactions.create(
                                      credit_card_number: "4321876554321234",
                                      result: 'success')
      transaction3 = invoice2.transactions.create(
                                      credit_card_number: "4321876554321234",
                                      result: 'success')

      get :transactions, format: :json, customer_id: customer1.id

      transactions = JSON.parse(response.body, symbolize_names: true)
      transaction  = transactions.first

      expect(response).to                         be_success
      expect(transactions.count).to               eq 3
      expect(transaction[:id]).to                 eq 1
      expect(transaction[:result]).to             eq "failed"
      expect(transaction[:credit_card_number]).to eq "4321876554329876"
    end
  end
end
