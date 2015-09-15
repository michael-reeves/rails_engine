class Merchant < ActiveRecord::Base
  has_many :items
  has_many :invoices

  validates :name, presence: true

  def self.names(name)
    where('LOWER(name) LIKE ?', name.downcase)
  end
end
