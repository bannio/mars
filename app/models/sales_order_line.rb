class SalesOrderLine < ActiveRecord::Base
  # attr_accessible :description, :name, :quantity, :sales_order_id, :total, :total, :unit_price, :unit_price
  belongs_to :sales_order
  acts_as_list scope: :sales_order
  
  has_many :sales_links
  has_many :purchase_order_lines, through: :sales_links
  
  before_save :update_total
  after_save :update_order_total
  after_destroy :update_order_total

  validates :name, presence: true

  protected

  def update_total
  	self.quantity ||= 0
    self.unit_price ||=0
    self.total = self.quantity * self.unit_price
  end

  def update_order_total
    sales_order.update_total
  end
end
