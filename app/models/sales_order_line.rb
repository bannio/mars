class SalesOrderLine < ActiveRecord::Base
  # attr_accessible :description, :name, :quantity, :sales_order_id, :total, :total, :unit_price, :unit_price
  belongs_to :sales_order
  before_save :update_total

  validates :name, presence: true

  protected
  def update_total
  	self.quantity ||= 0
    self.unit_price ||=0
    self.total = self.quantity * self.unit_price
  end
end
