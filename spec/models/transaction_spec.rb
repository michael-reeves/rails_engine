require 'rails_helper'

describe Transaction do
  before do
    @transaction = Transaction.new(invoice_id: 1,
                               credit_card_number: "4354495077693036",
                               result: 'failed')
  end

  it 'is valid with correct data' do
    expect(@transaction).to be_valid
  end

  describe '#invoice_id' do
    it 'is invalid without a invoice_id' do
      @transaction.invoice_id = ""
      expect(@transaction).to be_invalid
    end
  end

  describe '#credit_card_number' do
    it 'is invalid without a credit_card_number' do
      @transaction.credit_card_number = ""
      expect(@transaction).to be_invalid
    end
  end

  describe '#result' do
    it 'is invalid without a result' do
      @transaction.result = ""
      expect(@transaction).to be_invalid
    end
  end
end
