class PurchaseOrder < ActiveRecord::Base
  belongs_to :project
  belongs_to :customer, class_name: 'Company'
  belongs_to :supplier, class_name: 'Company'
  belongs_to :client, class_name: 'Company'
  belongs_to :contact
  belongs_to :address
  belongs_to :delivery_address, class_name: 'Address'
  has_many  :purchase_order_lines, order: :position, dependent: :destroy
  accepts_nested_attributes_for :purchase_order_lines
  has_many :events, as: :eventable
  has_many :emails, as: :emailable
  accepts_nested_attributes_for :emails

  validates :customer_id, :supplier_id, :project_id, :name, 
            :contact_id, :client_id, :due_date, presence: true

  STATES = %w[open issued cancelled delivered paid]
  delegate :open?, :issued?, :cancelled?, :delivered?, :paid?, to: :current_state

  scope :current, where(status: ['open','issued','delivered'])

  def current_state
    # (events.last.try(:state) || STATES.first).inquiry
    status.inquiry
  end

  def update_total
    update_attributes(total: purchase_order_lines.sum(:total))
  end

  def import(file)
    CSV.foreach(file.path, headers: true) do |row|
      self.purchase_order_lines.create(row.to_hash)
    end
  end

  def to_csv
    col_names = %w[category name description quantity unit_price]
    CSV.generate do |csv|
      csv << col_names
      purchase_order_lines.each do |line|
        csv << line.attributes.values_at(*col_names)
      end
    end
  end

  def self.next_code
    last ? last.code.gsub(/R\d+$/, '').next : 'PO0001'
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

  def delivery_name
    if delivery_address
      delivery_address.company.name
    else
      'No delivery address'
    end
  end

  def issue(user)
    errors.add(:base, "Only open purchase orders may be issued.") if !open? 
    errors.add(:base, "There are no lines on this order.") if purchase_order_lines.empty?
    if errors.size == 0
      events.create!(state: "issued", user_id: user.id)
    else
      false
    end
  end

  def reopen(user)
    errors.add(:base, "Only issued purchase orders can be re-opened") if !issued?
    if errors.size == 0
    events.create!(state: "open", user_id: user.id)
    else
      false
    end
  end

  def receipt(user)
    events.create!(state: "delivered", user_id: user.id) if issued? 
  end

  def cancel(user)
    events.create!(state: "cancelled", user_id: user.id) if issued? || open?
  end

  def paid(user)
    events.create!(state: "paid", user_id: user.id) if delivered? 
  end

  def create_pdf
    output_path = File.join(ENV["MARS_DATA"], 'purchaseorder')
    filename = "#{self.code}.pdf"
    PurchaseOrderPdf.new(self).render_file(File.join(output_path, filename))
  end

  private
  def self.search(search)
    if search.present?
      where('purchase_orders.name ilike :q', q: "%#{search}%")
    else
      scoped
    end
  end
end
