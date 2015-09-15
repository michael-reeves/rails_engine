class Api::V1::MerchantsController < ApplicationController
  respond_to :json

  def index
    respond_with Merchant.all
  end

  def show
    respond_with Merchant.find_by(id: params[:id])
  end

  def find
    respond_with Merchant.find_by(id: params[:id]) || Merchant.find_by(name: params[:name])

  end

  def find_all
    respond_with Merchant.find_by(id: params[:id]) || Merchant.names(params[:name])
  end

  def random
    respond_with Merchant.order('RANDOM()').first
  end
end
