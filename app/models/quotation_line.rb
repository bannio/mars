class QuotationLine < ActiveRecord::Base
  # attr_accessible :description, :name, :quantity, :total, :unit_price
  
  belongs_to :quotation
  acts_as_list scope: :quotation
  before_save :update_total
  after_save :update_quotation_total
  after_destroy :update_quotation_total
  
  validates :name, presence: true
  
  protected
  def update_total
    self.quantity ||= 0
    self.unit_price ||=0
    self.total = self.quantity * self.unit_price
  end

  def update_quotation_total
    quotation.update_total
  end
end
