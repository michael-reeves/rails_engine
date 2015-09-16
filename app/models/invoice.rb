class Invoice < ActiveRecord::Base
  extend RailsEngineBase

  belongs_to :customer
  belongs_to :merchant

  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :transactions

  validates :customer_id, presence: true
  validates :merchant_id, presence: true
  validates :status,      presence: true
end
