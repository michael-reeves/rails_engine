class Api::V1::ItemsController < ApplicationController
  respond_to :json

  before_action :get_item, only: [:invoice_items, :merchant]

  def index
    respond_with Item.all
  end

  def show
    respond_with Item.find_by(id: params[:id])
  end

  def find
    respond_with Item.find_by(find_params)
  end

  def find_all
    respond_with Item.where(find_params)
  end

  def random
    respond_with Item.order('RANDOM()').first
  end

  def invoice_items
    respond_with @item.invoice_items
  end

  def merchant
    respond_with @item.merchant
  end

  private

    def find_params
      params.permit(:id, :name, :description, :unit_price,
                    :merchant_id, :created_at, :updated_at)
    end

    def get_item
      @item = Item.find_by(id: params[:item_id])
    end
end
