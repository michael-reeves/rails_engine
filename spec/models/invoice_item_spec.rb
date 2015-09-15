require 'rails_helper'

describe InvoiceItem do
  before do
    @invoice_item = InvoiceItem.new(item_id:  1, invoice_id: 1,
                                    quantity: 5, unit_price: 11350 )
  end

  it 'is valid with correct data' do
    expect(@invoice_item).to be_valid
  end

  describe '#item_id' do
    it 'is invalid without a item_id' do
      @invoice_item.item_id = ""
      expect(@invoice_item).to be_invalid
    end
  end

  describe '#invoice_id' do
    it 'is invalid without a invoice_id' do
      @invoice_item.invoice_id = ""
      expect(@invoice_item).to be_invalid
    end
  end

  describe '#quantity' do
    it 'is invalid with a quantity of 0' do
      @invoice_item.quantity = 0
      expect(@invoice_item).to be_invalid
    end

    it 'is invalid with a negative quantity' do
      @invoice_item.quantity = -50
      expect(@invoice_item).to be_invalid
    end

    it 'is invalid without a quantity' do
      @invoice_item.quantity = ""
      expect(@invoice_item).to be_invalid
    end

    it 'is invalid with a string for a quantity' do
      @invoice_item.quantity = "blah"
      expect(@invoice_item).to be_invalid
    end
  end

  describe '#unit_price' do
    it 'is invalid with a unit_price of 0' do
      @invoice_item.unit_price = 0
      expect(@invoice_item).to be_invalid
    end

    it 'is invalid with a negative unit_price' do
      @invoice_item.unit_price = -50
      expect(@invoice_item).to be_invalid
    end

    it 'is invalid without a unit_price' do
      @invoice_item.unit_price = ""
      expect(@invoice_item).to be_invalid
    end

    it 'is invalid with a string for a unit_price' do
      @invoice_item.unit_price = "blah"
      expect(@invoice_item).to be_invalid
    end
  end
end
