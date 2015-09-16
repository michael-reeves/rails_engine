require 'rails_helper'

describe Api::V1::ItemsController do
  let!(:merchant) { Merchant.create!(name:"Store 1") }
  let!(:item1) { Item.create!(name: "Item 1",
                              description: "Some text",
                              unit_price: 299,
                              merchant_id: merchant.id)
               }
  let!(:item2) { Item.create!(name: "Item 2",
                              description: "Some other text",
                              unit_price: 399,
                              merchant_id: merchant.id)
               }

  let!(:item3) { Item.create!(name: "Item 3",
                              description: "Some final text",
                              unit_price: 399,
                              merchant_id: merchant.id)
               }

  describe 'GET #index' do
    it 'populates an array of Items' do
      get :index, format: :json

      items = JSON.parse(response.body, symbolize_names: true)
      item  = items.first

      expect(response).to           be_success
      expect(items.count).to        eq 3
      expect(item[:name]).to        eq 'Item 1'
      expect(item[:description]).to eq 'Some text'
      expect(item[:unit_price]).to  eq 299
    end
  end

  describe 'GET #show' do
    it 'returns an Item' do
      get :show, format: :json, id: item1.id

      item = JSON.parse(response.body, symbolize_names: true)

      expect(response).to           be_success
      expect(item[:name]).to        eq 'Item 1'
      expect(item[:description]).to eq 'Some text'
      expect(item[:unit_price]).to  eq 299
    end
  end

  describe 'GET #find' do
    it 'finds an Item by id' do
      get :find, format: :json, id: item1.id

      item = JSON.parse(response.body, symbolize_names: true)

      expect(response).to           be_success
      expect(item[:name]).to        eq 'Item 1'
      expect(item[:description]).to eq 'Some text'
      expect(item[:unit_price]).to  eq 299
    end

    it 'finds an Item by name' do
      get :find, format: :json, name: item1.name

      item = JSON.parse(response.body, symbolize_names: true)

      expect(response).to           be_success
      expect(item[:name]).to        eq 'Item 1'
      expect(item[:description]).to eq 'Some text'
      expect(item[:unit_price]).to  eq 299
    end

    it 'finds an Item by description' do
      get :find, format: :json, description: item1.description

      item = JSON.parse(response.body, symbolize_names: true)

      expect(response).to           be_success
      expect(item[:name]).to        eq 'Item 1'
      expect(item[:description]).to eq 'Some text'
      expect(item[:unit_price]).to  eq 299
    end

    it 'finds an Item by unit_price' do
      get :find, format: :json, unit_price: item1.unit_price

      item = JSON.parse(response.body, symbolize_names: true)

      expect(response).to           be_success
      expect(item[:name]).to        eq 'Item 1'
      expect(item[:description]).to eq 'Some text'
      expect(item[:unit_price]).to  eq 299
    end

    it 'finds an Item by merchant_id' do
      get :find, format: :json, merchant_id: item1.merchant_id

      item = JSON.parse(response.body, symbolize_names: true)

      expect(response).to           be_success
      expect(item[:name]).to        eq 'Item 1'
      expect(item[:description]).to eq 'Some text'
      expect(item[:unit_price]).to  eq 299
    end
  end

  describe 'GET #find_all' do
    it 'finds all Items by id' do
      get :find_all, format: :json, id: item1.id

      items = JSON.parse(response.body, symbolize_names: true)
      item  = items.first

      expect(response).to           be_success
      expect(items.count).to        eq 1
      expect(item[:name]).to        eq 'Item 1'
      expect(item[:description]).to eq 'Some text'
      expect(item[:unit_price]).to  eq 299
    end

    it 'finds all Items by name' do
      get :find_all, format: :json, name: item1.name

      items = JSON.parse(response.body, symbolize_names: true)
      item  = items.first

      expect(response).to           be_success
      expect(items.count).to        eq 1
      expect(item[:name]).to        eq 'Item 1'
      expect(item[:description]).to eq 'Some text'
      expect(item[:unit_price]).to  eq 299
    end

    it 'finds all Items by description' do
      get :find_all, format: :json, description: item1.description

      items = JSON.parse(response.body, symbolize_names: true)
      item  = items.first

      expect(response).to           be_success
      expect(items.count).to        eq 1
      expect(item[:name]).to        eq 'Item 1'
      expect(item[:description]).to eq 'Some text'
      expect(item[:unit_price]).to  eq 299
    end

    it 'finds all Items by unit_price' do
      get :find_all, format: :json, unit_price: item2.unit_price

      items = JSON.parse(response.body, symbolize_names: true)
      item  = items.first

      expect(response).to           be_success
      expect(items.count).to        eq 2
      expect(item[:name]).to        eq 'Item 2'
      expect(item[:description]).to eq 'Some other text'
      expect(item[:unit_price]).to  eq 399
    end

    it 'finds all Items by merchant_id' do
      get :find_all, format: :json, merchant_id: item1.merchant_id

      items = JSON.parse(response.body, symbolize_names: true)
      item  = items.first

      expect(response).to           be_success
      expect(items.count).to        eq 3
      expect(item[:name]).to        eq 'Item 1'
      expect(item[:description]).to eq 'Some text'
      expect(item[:unit_price]).to  eq 299
    end
  end

  describe 'GET #random' do
    it 'returns a random Item' do
      get :random, format: :json

      item = JSON.parse(response.body, symbolize_names: true)

      expect(response).to               be_success
      expect(item[:id]).not_to          be_nil
      expect(item[:name]).not_to        be_nil
      expect(item[:description]).not_to be_nil
      expect(item[:unit_price]).not_to  be_nil
      expect(item[:merchant_id]).not_to be_nil
    end
  end

  describe 'GET #invoice_items' do
    it 'returns a collection of associated invoice_items' do
      merchant1 = Merchant.create(name: 'Stark')
      customer1 = Customer.create!(first_name: "Jon",  last_name: "Snow")
      customer2 = Customer.create!(first_name: "Arya",  last_name: "Stark")

      invoice1 = Invoice.create(merchant_id: merchant.id,
                                customer_id: customer1.id, status: 'ordered')
      invoice2 = Invoice.create(merchant_id: merchant1.id,
                                customer_id: customer2.id, status: 'shipped')

      item = Item.create(name:        "First item",
                         description: "First description",
                         unit_price:  399,
                         merchant_id: merchant.id)
      invoice_item1 = invoice1.invoice_items.create(item_id: item.id,
                                                    quantity: 4,
                                                    unit_price: item.unit_price)
      invoice_item2 = invoice2.invoice_items.create(item_id:    item.id,
                                                    quantity:   10,
                                                    unit_price: item.unit_price)

      get :invoice_items, format: :json, item_id: item.id

      invoice_items = JSON.parse(response.body, symbolize_names: true)
      invoice_item  = invoice_items.first

      expect(response).to                  be_success
      expect(invoice_items.count).to       eq 2
      expect(invoice_item[:id]).to         eq 1
      expect(invoice_item[:invoice_id]).to eq invoice1.id
      expect(invoice_item[:quantity]).to   eq 4
      expect(invoice_item[:unit_price]).to eq 399
    end
  end

  describe 'GET #merchant' do
    it 'returns the merchant for the item' do
      get :merchant, format: :json, item_id: item1.id

      merchant_response = JSON.parse(response.body, symbolize_names: true)

      expect(response).to                 be_success
      expect(merchant_response[:id]).to   eq 1
      expect(merchant_response[:name]).to eq 'Store 1'
    end
  end
end
