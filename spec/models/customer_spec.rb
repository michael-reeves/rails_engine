require 'rails_helper'

describe Customer do

  before do
    @customer = Customer.new(first_name: 'John', last_name: 'Doe')
  end

  it 'is valid with a first_name and last_name' do
    expect(@customer).to be_valid
  end

  describe '#first_name' do
    it 'is invalid without a first_name' do
      @customer.first_name = ""
      expect(@customer).to be_invalid
    end
  end

  describe '#last_name' do
    it 'is invalid without a last_name' do
      @customer.last_name = ""
      expect(@customer).to be_invalid
    end
  end
end
