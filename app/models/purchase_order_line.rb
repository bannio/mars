class PurchaseOrderLine < ApplicationRecord
  belongs_to :purchase_order
  acts_as_list scope: :purchase_order
  has_many :sales_links, dependent: :destroy
  has_many :sales_order_lines, through: :sales_links

  include PgSearch

  pg_search_scope :full_text_search,
                  against: {name: 'A', description: 'B'},
                  using: {tsearch: {dictionary: 'english',
                                    prefix: true}
                  }

  # attr_accessible :description, :name, :quantity, :total, :unit_price
  before_save :update_total
  after_save :update_order_total
  after_destroy :update_order_total

  validates :name, presence: true

  protected
  def update_total
  	self.quantity ||= 0
    self.unit_price ||= 0
    self.discount ||= 0
    self.total = self.quantity * self.unit_price * (1 - self.discount/100)
  end

  def update_order_total
    # purchase_order.update_attributes(total: purchase_order.update_total)
    purchase_order.update_total
  end
end
