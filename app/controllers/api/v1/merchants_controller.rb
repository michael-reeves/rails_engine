class Api::V1::MerchantsController < ApplicationController
  respond_to :json

  before_action :get_merchant, only: [:items, :invoices, :merchant_revenue]

  def index
    respond_with Merchant.all
  end

  def show
    respond_with Merchant.find_by(id: params[:id])
  end

  def find
    respond_with Merchant.find_by(find_params)
  end

  def find_all
    respond_with Merchant.where(find_params)
  end

  def random
    respond_with Merchant.order('RANDOM()').first
  end

  def items
    respond_with @merchant.items
  end

  def invoices
    respond_with @merchant.invoices
  end

  def most_revenue
    respond_with Merchant.most_revenue(params[:quantity])
  end

  def most_items
    respond_with Merchant.most_items(params[:quantity])
  end

  def revenue
    respond_with total_revenue: Merchant.revenue(params[:date])
  end

  def merchant_revenue
    if date = params[:date]
      respond_with revenue: @merchant.revenue_per_day(date)
    else
      respond_with revenue: @merchant.total_revenue
    end
  end

  private

    def find_params
      params.permit(:id, :name, :created_at, :updated_at)
    end

    def get_merchant
      @merchant = Merchant.find_by(id: params[:merchant_id])
    end
end
