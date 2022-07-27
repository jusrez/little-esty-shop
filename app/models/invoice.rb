class Invoice < ApplicationRecord
  validates :status, presence: true
  validates :customer_id, presence: true
  has_many :invoice_items, dependent: :destroy
  has_many :transactions, dependent: :destroy
  has_many :items, through: :invoice_items
  belongs_to :customer
  has_many :merchants, through: :items

  enum status: { "in progress": 0, "completed": 1, "cancelled": 2}

  def total_revenue
    invoice_items.sum("quantity * unit_price")
  end
  
end
