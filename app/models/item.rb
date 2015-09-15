class Item < ActiveRecord::Base
  belongs_to :merchant
  has_many   :invoice_items
  has_many   :invoices, through: :invoice_items

  validates :name,        presence: true
  validates :description, presence: true
  validates :unit_price,  presence: true,
                          numericality: { only_integer:true,
                                          greater_than_or_equal_to: 0 }
  validates :merchant_id, presence: true
end
