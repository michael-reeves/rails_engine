require 'rails_helper'

describe Invoice do
  before do
    @invoice = Invoice.new(customer_id: 1, merchant_id: 1, status: "success")
  end

  it 'is valid with correct data' do
    expect(@invoice).to be_valid
  end

  describe '#customer_id' do
    it 'is invalid without a customer_id' do
      @invoice.customer_id = ""
      expect(@invoice).to be_invalid
    end
  end

  describe '#merchant_id' do
    it 'is invalid without a merchant_id' do
      @invoice.merchant_id = ""
      expect(@invoice).to be_invalid
    end
  end

  describe '#status' do
    it 'is invalid without a status' do
      @invoice.status = ""
      expect(@invoice).to be_invalid
    end
  end
end
