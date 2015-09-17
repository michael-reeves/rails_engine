class Api::V1::CustomersController < ApplicationController
  respond_to :json

  before_action :get_customer, only: [:invoices, :transactions,
                                      :favorite_merchant]

  def index
    respond_with Customer.all
  end

  def show
    respond_with Customer.find_by(id: params[:id])
  end

  def find
    respond_with Customer.find_by(find_params)
  end

  def find_all
    respond_with Customer.where(find_params)
  end

  def random
    respond_with Customer.order('RANDOM()').first
  end

  def invoices
    respond_with @customer.invoices
  end

  def transactions
    respond_with @customer.transactions
  end

  def favorite_merchant
    respond_with @customer.favorite_merchant
  end

  private

    def find_params
      params.permit(:id, :first_name, :last_name, :created_at, :updated_at)
    end

    def get_customer
      @customer = Customer.find_by(id: params[:customer_id])
    end
end
