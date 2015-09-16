require 'rails_helper'

describe Api::V1::InvoiceItemsController do
  let!(:customer) { Customer.create!(first_name: "Jane", last_name: "Doe")}
  let!(:merchant) { Merchant.create!(name: "Store 1") }

  let!(:item1) { Item.create!(name:        "Item 1",
                              description: "Some text",
                              unit_price:  299,
                              merchant_id: merchant.id)
               }
  let!(:item2) { Item.create!(name:        "Item 2",
                              description: "Some other text",
                              unit_price:  399,
                              merchant_id: merchant.id)
               }

  let!(:invoice1) { Invoice.create!(status:      "ordered",
                                    customer_id: customer.id,
                                    merchant_id: merchant.id)
                  }
  let!(:invoice2) { Invoice.create!(status:      "shipped",
                                    customer_id: customer.id,
                                    merchant_id: merchant.id)
                  }

  let!(:invoice_item1) { InvoiceItem.create!(item_id:    item1.id,
                                             invoice_id: invoice1.id,
                                             quantity:   3,
                                             unit_price: item1.unit_price)
                       }
  let!(:invoice_item2) { InvoiceItem.create!(item_id:    item2.id,
                                             invoice_id: invoice1.id,
                                             quantity:   5,
                                             unit_price: item2.unit_price)
                       }
  let!(:invoice_item3) { InvoiceItem.create!(item_id:    item1.id,
                                             invoice_id: invoice2.id,
                                             quantity:   4,
                                             unit_price: item1.unit_price)
                       }
  let!(:invoice_item4) { InvoiceItem.create!(item_id:    item2.id,
                                             invoice_id: invoice2.id,
                                             quantity:   6,
                                             unit_price: item2.unit_price)
                       }


  describe 'GET #index' do
    it 'populates an array of InvoiceItems' do
      get :index, format: :json

      invoice_items = JSON.parse(response.body, symbolize_names: true)
      invoice_item  = invoice_items.first

      expect(response).to                  be_success
      expect(invoice_items.count).to       eq 4
      expect(invoice_item[:item_id]).to    eq 1
      expect(invoice_item[:invoice_id]).to eq 1
      expect(invoice_item[:quantity]).to   eq 3
      expect(invoice_item[:unit_price]).to eq 299
    end
  end

  describe 'GET #show' do
    it 'returns an InvoiceItem' do
      get :show, format: :json, id: invoice_item1.id

      invoice_item = JSON.parse(response.body, symbolize_names: true)

      expect(response).to                  be_success
      expect(invoice_item[:item_id]).to    eq 1
      expect(invoice_item[:invoice_id]).to eq 1
      expect(invoice_item[:quantity]).to   eq 3
      expect(invoice_item[:unit_price]).to eq 299
    end
  end

  describe 'GET #find' do
    it 'finds an InvoiceItem by id' do
      get :find, format: :json, id: invoice_item1.id

      invoice_item = JSON.parse(response.body, symbolize_names: true)

      expect(response).to                  be_success
      expect(invoice_item[:item_id]).to    eq 1
      expect(invoice_item[:invoice_id]).to eq 1
      expect(invoice_item[:quantity]).to   eq 3
      expect(invoice_item[:unit_price]).to eq 299
    end

    it 'finds an InvoiceItem by item_id' do
      get :find, format: :json, item_id: invoice_item1.item_id

      invoice_item = JSON.parse(response.body, symbolize_names: true)

      expect(response).to                  be_success
      expect(invoice_item[:item_id]).to    eq 1
      expect(invoice_item[:invoice_id]).to eq 1
      expect(invoice_item[:quantity]).to   eq 3
      expect(invoice_item[:unit_price]).to eq 299
    end

    it 'finds an InvoiceItem by invoice_id' do
      get :find, format: :json, invoice_id: invoice_item1.invoice_id

      invoice_item = JSON.parse(response.body, symbolize_names: true)

      expect(response).to                  be_success
      expect(invoice_item[:item_id]).to    eq 1
      expect(invoice_item[:invoice_id]).to eq 1
      expect(invoice_item[:quantity]).to   eq 3
      expect(invoice_item[:unit_price]).to eq 299
    end

    it 'finds an InvoiceItem by quantity' do
      get :find, format: :json, quantity: invoice_item1.quantity

      invoice_item = JSON.parse(response.body, symbolize_names: true)

      expect(response).to                  be_success
      expect(invoice_item[:item_id]).to    eq 1
      expect(invoice_item[:invoice_id]).to eq 1
      expect(invoice_item[:quantity]).to   eq 3
      expect(invoice_item[:unit_price]).to eq 299
    end

    it 'finds an InvoiceItem by unit_price' do
      get :find, format: :json, unit_price: invoice_item1.unit_price

      invoice_item = JSON.parse(response.body, symbolize_names: true)

      expect(response).to                  be_success
      expect(invoice_item[:item_id]).to    eq 1
      expect(invoice_item[:invoice_id]).to eq 1
      expect(invoice_item[:quantity]).to   eq 3
      expect(invoice_item[:unit_price]).to eq 299
    end
  end

  describe 'GET #find_all' do
    it 'finds all InvoiceItems by id' do
      get :find_all, format: :json, id: invoice_item1.id

      invoice_items = JSON.parse(response.body, symbolize_names: true)
      invoice_item  = invoice_items.first

      expect(response).to                  be_success
      expect(invoice_items.count).to       eq 1
      expect(invoice_item[:item_id]).to    eq 1
      expect(invoice_item[:invoice_id]).to eq 1
      expect(invoice_item[:quantity]).to   eq 3
      expect(invoice_item[:unit_price]).to eq 299
    end

    it 'finds all InvoiceItems by item_id' do
      get :find_all, format: :json, item_id: invoice_item4.item_id

      invoice_items = JSON.parse(response.body, symbolize_names: true)
      invoice_item  = invoice_items.first

      expect(response).to                  be_success
      expect(invoice_items.count).to       eq 2
      expect(invoice_item[:item_id]).to    eq 2
      expect(invoice_item[:invoice_id]).to eq 1
      expect(invoice_item[:quantity]).to   eq 5
      expect(invoice_item[:unit_price]).to eq 399
    end

    it 'finds all InvoiceItems by invoice_id' do
      get :find_all, format: :json, invoice_id: invoice_item3.invoice_id

      invoice_items = JSON.parse(response.body, symbolize_names: true)
      invoice_item  = invoice_items.first

      expect(response).to                  be_success
      expect(invoice_items.count).to       eq 2
      expect(invoice_item[:item_id]).to    eq 1
      expect(invoice_item[:invoice_id]).to eq 2
      expect(invoice_item[:quantity]).to   eq 4
      expect(invoice_item[:unit_price]).to eq 299
    end

    it 'finds all InvoiceItems by quantity' do
      get :find_all, format: :json, quantity: invoice_item1.quantity

      invoice_items = JSON.parse(response.body, symbolize_names: true)
      invoice_item  = invoice_items.first

      expect(response).to                  be_success
      expect(invoice_items.count).to       eq 1
      expect(invoice_item[:item_id]).to    eq 1
      expect(invoice_item[:invoice_id]).to eq 1
      expect(invoice_item[:quantity]).to   eq 3
      expect(invoice_item[:unit_price]).to eq 299
    end

    it 'finds all InvoiceItems by unit_price' do
      get :find_all, format: :json, unit_price: invoice_item2.unit_price

      invoice_items = JSON.parse(response.body, symbolize_names: true)
      invoice_item  = invoice_items.first

      expect(response).to                  be_success
      expect(invoice_items.count).to       eq 2
      expect(invoice_item[:item_id]).to    eq 2
      expect(invoice_item[:invoice_id]).to eq 1
      expect(invoice_item[:quantity]).to   eq 5
      expect(invoice_item[:unit_price]).to eq 399
    end
  end

  describe 'GET #random' do
    it 'returns a random InvoiceItem' do
      get :random, format: :json

      invoice_item = JSON.parse(response.body, symbolize_names: true)

      expect(response).to                      be_success
      expect(invoice_item[:id]).not_to         be_nil
      expect(invoice_item[:item_id]).not_to    be_nil
      expect(invoice_item[:invoice_id]).not_to be_nil
      expect(invoice_item[:quantity]).not_to   be_nil
      expect(invoice_item[:unit_price]).not_to be_nil
    end
  end
end
