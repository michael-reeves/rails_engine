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
end
