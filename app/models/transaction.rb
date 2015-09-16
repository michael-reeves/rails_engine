class Transaction < ActiveRecord::Base
  extend RailsEngineBase
  
  belongs_to :invoice

  validates :invoice_id,         presence: true
  validates :credit_card_number, presence: true
  validates :result,             presence: true
end
