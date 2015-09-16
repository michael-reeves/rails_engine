class Customer < ActiveRecord::Base
  extend RailsEngineBase

  has_many :invoices
  has_many :transactions, through: :invoices

  validates :first_name, presence: true
  validates :last_name,  presence: true
end
