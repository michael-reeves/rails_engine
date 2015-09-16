class Api::V1::InvoicesController < ApplicationController
  respond_to :json

  def index
    respond_with Invoice.all
  end

  def show
    respond_with Invoice.find_by(id: params[:id])
  end

  def find
    respond_with Invoice.find(params)
  end

  def find_all
    respond_with Invoice.find_all(params)
  end

  def random
    respond_with Invoice.random
  end

  def transactions
    invoice = Invoice.find(id: params[:invoice_id])
    respond_with invoice.transactions
  end

  def invoice_items
    invoice = Invoice.find(id: params[:invoice_id])
    respond_with invoice.invoice_items
  end

  def items
    invoice = Invoice.find(id: params[:invoice_id])
    respond_with invoice.items
  end

  def customer
    invoice = Invoice.find(id: params[:invoice_id])
    respond_with invoice.customer
  end

  def merchant
    invoice = Invoice.find(id: params[:invoice_id])
    respond_with invoice.merchant
  end
end
