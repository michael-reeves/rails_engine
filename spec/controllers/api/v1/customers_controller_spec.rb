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
end
