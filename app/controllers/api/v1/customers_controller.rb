class Api::V1::CustomersController < ApplicationController
  respond_to :json

  def index
    respond_with Customer.all
  end

  def show
    respond_with Customer.find_by(id: params[:id])
  end

  def find
    respond_with Customer.find(params)
  end

  def find_all
    respond_with Customer.find_all(params)
  end

  def random
    respond_with Customer.random
  end

  def invoices
    customer = Customer.find_by(id: params[:customer_id])
    respond_with customer.invoices
  end

  def transactions
    customer = Customer.find_by(id: params[:customer_id])
    respond_with customer.transactions
  end
end
