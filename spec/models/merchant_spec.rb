require 'rails_helper'

describe Merchant do
  before do
    @merchant = Merchant.new(name: 'AAA Farms')
  end

  it 'is valid with a name' do
    expect(@merchant).to be_valid
  end

  describe '#name' do
    it 'is invalid without a name' do
      @merchant.name = ""
      expect(@merchant).to be_invalid
    end
  end
end
