class Merchant < ActiveRecord::Base
  extend RailsEngineBase

  has_many :items
  has_many :invoices

  validates :name, presence: true
end
