class InvoiceItem < ActiveRecord::Base
  belongs_to :item
  belongs_to :invoice

  validates :item_id,    presence: true
  validates :invoice_id, presence: true
  validates :quantity,   presence: true,
                         numericality: { only_integer: true,
                                         greater_than: 0 }
  validates :unit_price, presence: true,
                         numericality: { greater_than: 0 }
end
