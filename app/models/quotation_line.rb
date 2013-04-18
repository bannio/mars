class QuotationLine < ActiveRecord::Base
  # attr_accessible :description, :name, :quantity, :total, :unit_price
  
  belongs_to :quotation
  before_save :update_total
  
  protected
  def update_total
    self.quantity ||= 0
    self.unit_price ||=0
    self.total = self.quantity * self.unit_price
  end
end
