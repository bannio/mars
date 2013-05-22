class PurchaseOrder < ActiveRecord::Base
  belongs_to :project
  belongs_to :customer, class_name: 'Company'
  belongs_to :supplier, class_name: 'Company'
  belongs_to :client, class_name: 'Company'
  belongs_to :contact
  belongs_to :address
  belongs_to :delivery_address, class_name: 'Address'
  # attr_accessible :code, :delivery_address_id, :description, :issue_date, :name, :notes, :status, :total
  has_many  :purchase_order_lines, dependent: :destroy
  accepts_nested_attributes_for :purchase_order_lines
  has_many :events, as: :eventable
  has_many :emails, as: :emailable
  accepts_nested_attributes_for :emails

  validates :customer_id, :supplier_id, :project_id, :name, :contact_id, :client_id, presence: true

  STATES = %w[open issued cancelled delivered paid]
  delegate :open?, :issued?, :cancelled?, :delivered?, :paid?, to: :current_state

  scope :current, where(status: ['open','issued','delivered'])

# could change this to use status field now?
  def current_state
    (events.last.try(:state) || STATES.first).inquiry
  end

  def update_total
  	total = purchase_order_lines.sum(:total)
  end

  def self.next_code
    last ? last.code.gsub(/R\d+$/, '').next : 'PO0001'
  end
end
