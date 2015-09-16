class Api::V1::MerchantsController < ApplicationController
  respond_to :json

  def index
    respond_with Merchant.all
  end

  def show
    respond_with Merchant.find_by(id: params[:id])
  end

  def find
    respond_with Merchant.find(params)
  end

  def find_all
    respond_with Merchant.find_all(params)
  end

  def random
    respond_with Merchant.random
  end

  def items
    merchant = Merchant.find(id: params[:merchant_id])
    respond_with merchant.items
  end

  def invoices
    merchant = Merchant.find(id: params[:merchant_id])
    respond_with merchant.invoices
  end
end
