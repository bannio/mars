class SalesOrder < ActiveRecord::Base
  #attr_accessible :address_id, :code, :contact_id, :customer_id, :delivery_address_id, :description, :issue_date, :name, :notes, :project_id, :supplier_id
  belongs_to :customer, class_name: 'Company'
  belongs_to :supplier, class_name: 'Company'
  belongs_to :project
  belongs_to :address
  belongs_to :contact
  belongs_to :delivery_address, class_name: 'Address'
  
  has_many  :sales_order_lines, dependent: :destroy
  accepts_nested_attributes_for :sales_order_lines
  has_many :events, as: :eventable
  has_many :emails, as: :emailable
  accepts_nested_attributes_for :emails
  
  validates :customer_id, :supplier_id, :project_id, :name, :contact_id, presence: true

  STATES = %w[open issued revised cancelled accepted invoiced paid]
  delegate :open?, :issued?, :revised?, :cancelled?, :accepted?, :invoiced?, to: :current_state
  
  def total
    total = sales_order_lines.sum(:total)
  end
  
  def self.open_sales_orders
    joins(:events).merge Event.with_last_state("open")
  end
  
  def current_state
    (events.last.try(:state) || STATES.first).inquiry
  end

  def reopen(user)
    errors.add(:base, "Only issued sales orders can be re-opened") if !issued?
    if errors.size == 0
    events.create!(state: "open", user_id: user.id)
    else
      false
    end
  end

  def self.next_code
    last ? last.code.gsub(/R\d+$/, '').next : 'SO0001'
  end

  def update_code
    # revision number
    if self.code.include?('R')
      self.code = self.code.next
    else
      self.code = self.code + 'R1'
    end
    save
  end
  
  def issue(user)
    errors.add(:base, "Only open sales orders may be issued.") if !open? 
    errors.add(:base, "There are no lines on this order.") if sales_order_lines.empty?
    if errors.size == 0
      events.create!(state: "issued", user_id: user.id)
    else
      false
    end
  end

  def cancel(user)
    events.create!(state: "cancelled", user_id: user.id) if open? || issued?
  end

  def accept(user)
  	events.create!(state: "accepted", user_id: user.id) if issued? 
  end

  def invoice(user)
    events.create!(state: "invoiced", user_id: user.id) if accepted? 
  end

  def paid(user)
    events.create!(state: "paid", user_id: user.id) if invoiced? 
  end

  def create_pdf
    output_path = File.join(Rails.root, 'data', 'salesorder')
    filename = "#{self.code}.pdf"
    SalesOrderPdf.new(self).render_file(File.join(output_path, filename))
  end

end
