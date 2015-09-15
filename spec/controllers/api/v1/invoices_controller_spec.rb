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
      expect(invoice[:status]).to      eq 'ordered'
      expect(invoice[:customer_id]).to eq 1
      expect(invoice[:merchant_id]).to eq 1
    end

    it 'finds an Invoice by merchant_id' do
      get :find, format: :json, merchant_id: invoice1.merchant_id

      invoice = JSON.parse(response.body, symbolize_names: true)

      expect(response).to              be_success
      expect(invoice[:status]).to      eq 'ordered'
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
    it 'returns a random invoice' do
      get :random, format: :json

      invoice = JSON.parse(response.body, symbolize_names: true)

      expect(response).to                  be_success
      expect(invoice[:id]).not_to          be_nil
      expect(invoice[:status]).not_to      be_nil
      expect(invoice[:customer_id]).not_to be_nil
      expect(invoice[:merchant_id]).not_to be_nil
    end
  end
end
