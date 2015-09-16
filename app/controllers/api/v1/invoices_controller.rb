class Api::V1::InvoicesController < ApplicationController
  respond_to :json

  def index
    respond_with Invoice.all
  end

  def show
    respond_with Invoice.find_by(id: params[:id])
  end

  def find
    respond_with Invoice.find_by(find_params)
  end

  def find_all
    respond_with Invoice.where(find_params)
  end

  def random
    respond_with Invoice.order('RANDOM()').first
  end

  def transactions
    invoice = Invoice.find_by(id: params[:invoice_id])
    respond_with invoice.transactions
  end

  def invoice_items
    invoice = Invoice.find_by(id: params[:invoice_id])
    respond_with invoice.invoice_items
  end

  def items
    invoice = Invoice.find_by(id: params[:invoice_id])
    respond_with invoice.items
  end

  def customer
    invoice = Invoice.find_by(id: params[:invoice_id])
    respond_with invoice.customer
  end

  def merchant
    invoice = Invoice.find_by(id: params[:invoice_id])
    respond_with invoice.merchant
  end

  private

    def find_params
      params.permit(:id, :status, :customer_id, :merchant_id,
                    :created_at, :updated_at)
    end
end
