class PurchaseOrderLine < ActiveRecord::Base
  belongs_to :purchase_order
  # attr_accessible :description, :name, :quantity, :total, :unit_price
  before_save :update_total
  after_save :update_order_total

  validates :name, presence: true

  protected
  def update_total
  	self.quantity ||= 0
    self.unit_price ||=0
    self.total = self.quantity * self.unit_price
  end

  def update_order_total
    purchase_order.update_attributes(total: purchase_order.update_total)
  end
end
