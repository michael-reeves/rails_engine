require 'rails_helper'

describe Api::V1::TransactionsController do
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

  let!(:transaction1) { Transaction.create!(invoice_id: 1,
                                            credit_card_number: "4321876554321234",
                                            result: "success")
                      }
  let!(:transaction2) { Transaction.create!(invoice_id: 2,
                                            credit_card_number: "4321876554329876",
                                            result: "failed")
                      }
  let!(:transaction3) { Transaction.create!(invoice_id: 2,
                                            credit_card_number: "4321876554321234",
                                            result: "success")
                      }


  describe 'GET #index' do
    it 'populates an array of Transactions' do
      get :index, format: :json

      transactions = JSON.parse(response.body, symbolize_names: true)
      transaction  = transactions.first

      expect(response).to                         be_success
      expect(transactions.count).to               eq 3
      expect(transaction[:invoice_id]).to         eq 1
      expect(transaction[:credit_card_number]).to eq '4321876554321234'
      expect(transaction[:result]).to             eq "success"
    end
  end

  describe 'GET #show' do
    it 'returns a single Transaction' do
      get :show, format: :json, id: transaction1.id

      transaction = JSON.parse(response.body, symbolize_names: true)

      expect(response).to                         be_success
      expect(transaction[:invoice_id]).to         eq 1
      expect(transaction[:credit_card_number]).to eq '4321876554321234'
      expect(transaction[:result]).to             eq "success"
    end
  end

  describe 'GET #find' do
    it 'finds a single Transaction by id' do
      get :find, format: :json, id: transaction1.id

      transaction = JSON.parse(response.body, symbolize_names: true)

      expect(response).to                         be_success
      expect(transaction[:invoice_id]).to         eq 1
      expect(transaction[:credit_card_number]).to eq '4321876554321234'
      expect(transaction[:result]).to             eq "success"
    end

    it 'finds a single Transaction by invoice_id' do
      get :find, format: :json, invoice_id: transaction1.invoice_id

      transaction = JSON.parse(response.body, symbolize_names: true)

      expect(response).to                         be_success
      expect(transaction[:invoice_id]).to         eq 1
      expect(transaction[:credit_card_number]).to eq '4321876554321234'
      expect(transaction[:result]).to             eq "success"
    end

    it 'finds a single Transaction by credit_card_number' do
      get :find, format: :json,
                 credit_card_number: transaction1.credit_card_number

      transaction = JSON.parse(response.body, symbolize_names: true)

      expect(response).to                         be_success
      expect(transaction[:invoice_id]).to         eq 1
      expect(transaction[:credit_card_number]).to eq '4321876554321234'
      expect(transaction[:result]).to             eq "success"
    end

    it 'finds a single Transaction by result' do
      get :find, format: :json, result: transaction2.result

      transaction = JSON.parse(response.body, symbolize_names: true)

      expect(response).to                         be_success
      expect(transaction[:invoice_id]).to         eq 2
      expect(transaction[:credit_card_number]).to eq '4321876554329876'
      expect(transaction[:result]).to             eq "failed"
    end
  end

  describe 'GET #find_all' do
    it 'finds all Transactions by id' do
      get :find_all, format: :json, id: transaction1.id

      transactions = JSON.parse(response.body, symbolize_names: true)
      transaction  = transactions.first

      expect(response).to                         be_success
      expect(transactions.count).to               eq 1
      expect(transaction[:invoice_id]).to         eq 1
      expect(transaction[:credit_card_number]).to eq '4321876554321234'
      expect(transaction[:result]).to             eq "success"
    end

    it 'finds all Transactions by invoice_id' do
      get :find_all, format: :json, invoice_id: transaction1.invoice_id

      transactions = JSON.parse(response.body, symbolize_names: true)
      transaction  = transactions.first

      expect(response).to                         be_success
      expect(transactions.count).to               eq 1
      expect(transaction[:invoice_id]).to         eq 1
      expect(transaction[:credit_card_number]).to eq '4321876554321234'
      expect(transaction[:result]).to             eq "success"
    end

    it 'finds all Transactions by credit_card_number' do
      get :find_all, format: :json,
                     credit_card_number: transaction1.credit_card_number

      transactions = JSON.parse(response.body, symbolize_names: true)
      transaction  = transactions.first

      expect(response).to                         be_success
      expect(transactions.count).to               eq 2
      expect(transaction[:invoice_id]).to         eq 1
      expect(transaction[:credit_card_number]).to eq '4321876554321234'
      expect(transaction[:result]).to             eq "success"
    end

    it 'finds all Transactions by result' do
      get :find_all, format: :json, result: transaction1.result

      transactions = JSON.parse(response.body, symbolize_names: true)
      transaction  = transactions.first

      expect(response).to                         be_success
      expect(transactions.count).to               eq 2
      expect(transaction[:invoice_id]).to         eq 1
      expect(transaction[:credit_card_number]).to eq '4321876554321234'
      expect(transaction[:result]).to             eq "success"
    end
  end

  describe 'GET #random' do
    it 'returns a random Transaction' do
      get :random, format: :json

      transaction = JSON.parse(response.body, symbolize_names: true)

      expect(response).to                             be_success
      expect(transaction[:id]).not_to                 be_nil
      expect(transaction[:invoice_id]).not_to         be_nil
      expect(transaction[:credit_card_number]).not_to be_nil
      expect(transaction[:result]).not_to             be_nil
    end
  end
end
