require 'rails_helper'

describe Api::V1::MerchantsController do
  let!(:merchant1) { Merchant.create!(name: "Lannister") }
  let!(:merchant2) { Merchant.create!(name: "Stark") }
  let!(:merchant3) { Merchant.create!(name: "Tyrell") }
  let!(:merchant4) { Merchant.create!(name: "Greyjoy") }

  describe 'GET #index' do
    it 'populates an array of Merchants' do
      get :index, format: :json

      merchants = JSON.parse(response.body, symbolize_names: true)
      merchant  = merchants.first

      expect(response).to        be_success
      expect(merchants.count).to eq 4
      expect(merchant[:name]).to eq 'Lannister'
    end
  end

  describe 'GET #show' do
    it 'returns a Merchant' do
      get :show, format: :json, id: merchant3.id

      merchant = JSON.parse(response.body, symbolize_names: true)

      expect(response).to            be_success
      expect(merchant[:name]).to eq 'Tyrell'
    end
  end

  describe 'GET #find' do
    it 'finds a Merchant by id' do
      get :find, format: :json, id: merchant4.id

      merchant = JSON.parse(response.body, symbolize_names: true)

      expect(response).to            be_success
      expect(merchant[:name]).to eq 'Greyjoy'
    end

    it 'finds a Merchant by name' do
      get :find, format: :json, name: merchant2.name

      merchant = JSON.parse(response.body, symbolize_names: true)

      expect(response).to            be_success
      expect(merchant[:name]).to eq 'Stark'
    end
  end

  describe 'GET #find_all' do
    it 'finds all Merchants by id' do
      get :find_all, format: :json, id: merchant1.id

      merchants = JSON.parse(response.body, symbolize_names: true)
      merchant  = merchants.first

      expect(response).to        be_success
      expect(merchants.count).to eq 1
      expect(merchant[:name]).to eq 'Lannister'
    end

    it 'finds all Merchants by name' do
      get :find_all, format: :json, name: merchant2.name

      merchants = JSON.parse(response.body, symbolize_names: true)
      merchant  = merchants.first

      expect(response).to            be_success
      expect(merchants.count).to     eq 1
      expect(merchant[:name]).to eq 'Stark'
    end
  end

  describe 'GET #random' do
    it 'returns a random Merchant' do
      get :random, format: :json

      merchant = JSON.parse(response.body, symbolize_names: true)

      expect(response).to            be_success
      expect(merchant[:id]).not_to   be_nil
      expect(merchant[:name]).not_to be_nil
    end
  end

  describe 'GET #items' do
    it 'an array of merchant items' do
      item1 = merchant1.items.create!(name: "Item 1",
                                      description: "Some text",
                                      unit_price: 299)
      item2 = merchant1.items.create!(name: "Item 2",
                                      description: "Some other text",
                                      unit_price: 399)
      item3 = merchant1.items.create!(name: "Item 3",
                                      description: "Some final text",
                                      unit_price: 399)

      get :items, format: :json, merchant_id: merchant1.id

      items = JSON.parse(response.body, symbolize_names: true)
      item  = items.first

      expect(response).to           be_success
      expect(item[:id]).to          eq 1
      expect(item[:name]).to        eq "Item 1"
      expect(item[:description]).to eq "Some text"
      expect(item[:unit_price]).to  eq 299
    end
  end

  describe 'GET #invoices' do
    it 'an array of merchant invoices' do
      customer1 = Customer.create!(first_name: "Jon",  last_name: "Snow")
      customer2 = Customer.create!(first_name: "Arya", last_name: "Stark")
      
      item1 = merchant1.invoices.create!(status:      "ordered",
                                         customer_id: customer1.id)
      item2 = merchant1.invoices.create!(status:      "shipped",
                                         customer_id: customer1.id)
      item3 = merchant1.invoices.create!(status:      "shipped",
                                         customer_id: customer2.id)

      get :invoices, format: :json, merchant_id: merchant1.id

      invoices = JSON.parse(response.body, symbolize_names: true)
      invoice  = invoices.last

      expect(response).to              be_success
      expect(invoice[:id]).to          eq 3
      expect(invoice[:status]).to      eq "shipped"
      expect(invoice[:customer_id]).to eq 2
    end
  end
end
