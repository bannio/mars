class Company < ApplicationRecord
  has_many :addresses
  has_many :contacts
  has_many :projects
  has_many :offered_quotations, class_name: 'Quotation', foreign_key: :supplier_id
  has_many :requested_quotations, class_name: 'Quotation', foreign_key: :customer_id
  has_many :offered_sales_orders, class_name: 'SalesOrder', foreign_key: :supplier_id
  has_many :requested_sales_orders, class_name: 'SalesOrder', foreign_key: :customer_id
  has_many :requested_purchase_orders, class_name: 'PurchaseOrder', foreign_key: :customer_id
  has_many :offered_purchase_orders, class_name: 'PurchaseOrder', foreign_key: :supplier_id

  validates_presence_of :name

  before_destroy :check_associations

  scope :owned, -> {where(name: ENV["OUR_COMPANY_NAMES"].split(/,/))}
  # scope :primary, where(name: ENV["OUR_COMPANY_NAMES"].split(/,/)).first

private

  def self.search(search)
    if search.present?
      where('name ilike :q', q: "%#{search}%")
    else
      all
    end
  end

  def check_associations
    if !contacts.empty? ||
      !offered_quotations.empty? ||
      !offered_purchase_orders.empty? ||
      !offered_sales_orders.empty? ||
      !requested_quotations.empty? ||
      !requested_purchase_orders.empty? ||
      !requested_sales_orders.empty? ||
      !addresses.empty? ||
      !projects.empty?
      throw(:abort) # to prevent destroy action
    else
      return true
    end
  end
end
