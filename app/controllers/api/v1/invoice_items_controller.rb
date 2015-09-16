class Api::V1::InvoiceItemsController < ApplicationController
  respond_to :json

  def index
    respond_with InvoiceItem.all
  end

  def show
    respond_with InvoiceItem.find_by(id: params[:id])
  end

  def find
    respond_with InvoiceItem.find_by(find_params)
  end

  def find_all
    respond_with InvoiceItem.where(find_params)
  end

  def random
    respond_with InvoiceItem.order('RANDOM()').first
  end

  def invoice
    invoice_item = InvoiceItem.find_by(id: params[:invoice_item_id])
    respond_with invoice_item.invoice
  end

  def item
    invoice_item = InvoiceItem.find_by(id: params[:invoice_item_id])
    respond_with invoice_item.item
  end

  private

    def find_params
      params.permit(:id, :item_id, :invoice_id, :quantity,
                    :unit_price, :created_at, :updated_at)
    end
end
