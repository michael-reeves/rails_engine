require 'rails_helper'

describe Item do
  before do
    @merchant = Merchant.create(name: "AAA Farms")

    @item = Item.new(name: 'waffle iron', description: 'fancy waffle iron',
                     unit_price: 12345, merchant_id: @merchant.id)
  end

  it 'is valid with a correct data' do
    expect(@item).to be_valid
  end

  describe '#name' do
    it 'is invalid without a name' do
      @item.name = ""

      expect(@item).to be_invalid
    end
  end

  describe '#description' do
    it 'is invalid without a description' do
      @item.description = ""

      expect(@item).to be_invalid
    end
  end

  describe '#unit_price' do
    it 'is invalid wth a unit_price of zero' do
      @item.unit_price = 0

      expect(@item).to be_invalid
    end

    it 'is invalid less than zero unit_price' do
      @item.unit_price = -10

      expect(@item).to be_invalid
    end

    it 'is invalid without a unit_price' do
      @item.unit_price = ""

      expect(@item).to be_invalid
    end

    it 'is invalid string for a unit_price' do
      @item.unit_price = "blah"

      expect(@item).to be_invalid
    end
  end

  describe '#merchant_id' do
    it 'is invalid without a merchant_id' do
      @item.merchant_id = ""

      expect(@item).to be_invalid
    end
  end
end
