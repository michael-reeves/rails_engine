class Merchant < ActiveRecord::Base
  has_many :items
  has_many :invoices
  has_many :invoice_items, through: :invoices
  has_many :transactions,  through: :invoices

  validates :name, presence: true

  def revenue(date = nil)
    invoices.paid.joins(:invoice_items).sum('unit_price * quantity')
  end

  def items_sold(date=nil)
    invoices.paid.joins(:invoice_items).sum('quantity')
  end

  def self.most_revenue(quantity)
    merchants = all.sort_by(&:revenue).reverse

    if quantity
      merchants.first(quantity.to_i)
    else
      merchants
    end
  end

  def self.most_items(quantity)
    merchants = all.sort_by(&:items_sold).reverse

    if quantity
      merchants.first(quantity.to_i)
    else
      merchants
    end
  end
end
