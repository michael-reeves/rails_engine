class Customer < ActiveRecord::Base
  has_many :invoices
  has_many :transactions, through: :invoices
  has_many :invoice_items, through: :invoices

  validates :first_name, presence: true
  validates :last_name,  presence: true

  def favorite_merchant
    merchant_id = invoices.paid.group(:merchant_id).count
                          .max_by{|_key, value| value }.first
                          
    Merchant.find(merchant_id)
  end
end
