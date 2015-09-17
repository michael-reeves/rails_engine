class Merchant < ActiveRecord::Base
  has_many :items
  has_many :invoices
  has_many :invoice_items, through: :invoices
  has_many :transactions,  through: :invoices

  validates :name, presence: true

  # Class methods
  def self.most_revenue(quantity)
    merchants = all.sort_by(&:total_revenue).reverse

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

  def self.revenue(date=nil)
    all.reduce(0) {|total, merchant| total + merchant.revenue_per_day(date) }
  end


  # Instance Methods
  def total_revenue
    paid_invoices.joins(:invoice_items).sum('unit_price * quantity')
  end

  def items_sold
    paid_invoices.joins(:invoice_items).sum('quantity')
  end

  def revenue_per_day(date = nil)
    invoices.where(created_at: date).paid.joins(:invoice_items).sum('unit_price * quantity')
  end

  private

  def paid_invoices
    invoices.paid
  end

end
