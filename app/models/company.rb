class Company < ActiveRecord::Base
  has_many :addresses, dependent: :restrict
  has_many :contacts, dependent: :restrict
  has_many :projects, dependent: :restrict
  has_many :offered_quotations, class_name: 'Quotation', foreign_key: :supplier_id
  has_many :requested_quotations, class_name: 'Quotation', foreign_key: :customer_id, dependent: :restrict
  has_many :offered_sales_orders, class_name: 'SalesOrder', foreign_key: :supplier_id, dependent: :restrict
  has_many :requested_sales_orders, class_name: 'SalesOrder', foreign_key: :customer_id, dependent: :restrict
  has_many :requested_purchase_orders, class_name: 'PurchaseOrder', foreign_key: :customer_id, dependent: :restrict
  has_many :offered_purchase_orders, class_name: 'PurchaseOrder', foreign_key: :supplier_id, dependent: :restrict
  
  validates_presence_of :name

  scope :owned, where(name: ENV["OUR_COMPANY_NAMES"].split(/,/))
  # scope :primary, where(name: ENV["OUR_COMPANY_NAMES"].split(/,/)).first
  
private
  
  def self.search(search)
    if search.present?
      where('name ilike :q', q: "%#{search}%")
    else
      scoped
    end
  end

end
