class Api::V1::TransactionsController < ApplicationController
  respond_to :json

  before_action :get_transaction, only: [:invoice]

  def index
    respond_with Transaction.all
  end

  def show
    respond_with Transaction.find_by(id: params[:id])
  end

  def find
    respond_with Transaction.find_by(find_params)
  end

  def find_all
    respond_with Transaction.where(find_params)
  end

  def random
    respond_with Transaction.order('RANDOM()').first
  end

  def invoice
    respond_with @transaction.invoice
  end

  private

    def find_params
      params.permit(:id, :invoice_id, :credit_card_number,
                    :result, :created_at, :updated_at)
    end

    def get_transaction
      @transaction = Transaction.find_by(id: params[:transaction_id])
    end
end
