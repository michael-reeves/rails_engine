class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  before_action :sanitize_params

  private
    def sanitize_params
      params[:id]              = params[:id].to_i
      params[:item_id]         = params[:item_id].to_i
      params[:invoice_id]      = params[:invoice_id].to_i
      params[:invoice_item_id] = params[:invoice_item_id].to_i
      params[:quantity]        = params[:quantity].to_i
      params[:unit_price]      = params[:unit_price].to_i
      params[:customer_id]     = params[:customer_id].to_i
      params[:merchant_id]     = params[:merchant_id].to_i
      params[:invoice_id]      = params[:invoice_id].to_i
      params[:date]            = Date.parse(params[:date]) if params[:date]
    end
end
