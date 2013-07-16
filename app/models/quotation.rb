class Quotation < ActiveRecord::Base
  # attr_accessible :address_id, :company_id, :contact_id, :issue_date, :name, :notes, :project_id, :status, :supplier_id, :total
  
  belongs_to :customer, class_name: 'Company'
  belongs_to :supplier, class_name: 'Company'
  belongs_to :project
  belongs_to :address
  belongs_to :contact
  belongs_to :delivery_address, class_name: 'Address'
  
  has_many  :quotation_lines, dependent: :destroy
  accepts_nested_attributes_for :quotation_lines
  has_many :events, as: :eventable
  has_many :emails, as: :emailable
  accepts_nested_attributes_for :emails

  scope :current, where(status: ['open','issued'])
  
  validates :customer_id, :supplier_id, :project_id, :name, :contact_id, presence: true
  
  STATES = %w[open issued cancelled ordered]
  delegate :open?, :issued?, :cancelled?, :ordered?, to: :current_state
  
  def update_total
    total = quotation_lines.sum(:total)
  end
  
  def import(file)
    CSV.foreach(file.path, headers: true) do |row|
      self.quotation_lines.create(row.to_hash)
    end
  end

  def to_csv
    col_names = %w[category name description quantity unit_price]
    CSV.generate do |csv|
      csv << col_names
      quotation_lines.each do |line|
        csv << line.attributes.values_at(*col_names)
      end
    end
  end
  
  def self.open_quotations
    joins(:events).merge Event.with_last_state("open")
  end
  
  def current_state
    (events.last.try(:state) || STATES.first).inquiry
  end
  
  def reopen(user)
    errors.add(:base, "Only issued quotations can be re-opened") if !issued?
    if errors.size == 0
    events.create!(state: "open", user_id: user.id)
    else
      fa
    end
  end

  def self.next_code
    last.code.gsub(/R\d+$/, '').next
  end
  
  def issue(user)
    errors.add(:base, "Only open quotations may be issued.") if !open? 
    errors.add(:base, "There are no lines on this quotation.") if quotation_lines.empty?
    #errors.add(:base, "There must be a contact with an email address to issue to.") if no_email? 
    if errors.size == 0
      events.create!(state: "issued", user_id: user.id)
    else
      false
    end
  end
  
  def no_email?
    if Contact.find(contact_id) && !Contact.find(contact_id).email.empty?
      false
    else 
      true
    end
  end
  
  def cancel(user)
    events.create!(state: "cancelled", user_id: user.id) if open? || issued?
  end
  
  def convert(user)
    # if issued then create a sales order and if saved successfully then create event
    events.create!(state: "ordered", user_id: user.id) if issued?
  end

  def clone_as_sales_order
    sales_order = SalesOrder.new(self.attributes)
    sales_order.code = SalesOrder.next_code
    sales_order.status = 'open'
    self.quotation_lines.each do |line|
      sales_order.sales_order_lines.build(name: line.name,
                                          description: line.description,
                                          quantity: line.quantity,
                                          unit_price: line.unit_price)
    end
    sales_order.save
  end

  def create_pdf
    output_path = File.join(ENV["MARS_DATA"], 'quotation')
    filename = "#{self.code}.pdf"
    SalesQuotePdf.new(self).render_file(File.join(output_path, filename))
  end

  private

  def self.search(search)
    if search.present?
      where('quotations.name ilike :q', q: "%#{search}%")
    else
      scoped
    end
  end
end
