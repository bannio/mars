class Project < ActiveRecord::Base

  belongs_to :company
  has_many  :quotations
  has_many  :sales_orders
  has_many  :sales_order_lines,
    -> {conditions "sales_orders.status in ('accepted','invoiced')"},
    through: :sales_orders
  has_many  :purchase_orders
  has_many  :events, as: :eventable

  validates_presence_of :company_id, :code, :name
  validate :valid_dates
  before_destroy :check_associations

  scope :current, ->{where(status: 'open')}

    STATES = %w[open closed]
  delegate :open?, :issued?, :cancelled?, :ordered?, to: :current_state

  def current_state
    status.inquiry
    # (events.last.try(:state) || STATES.first).inquiry
  end

  def quotes_total(status)
    quotations.where(status: status).sum(:total)
  end

  def sales_total(status)
    sales_orders.where(status: status).sum(:total)
  end

  def quotes_total_total
    quotations.current.sum(:total)
  end

  def sales_total_total
    sales_orders.where("status != 'cancelled'").sum(:total)
  end

  def purchase_total(status)
    purchase_orders.where(status: status).sum(:total)
  end

  def purchase_total_total
    purchase_orders.where("status != 'cancelled'").sum(:total)
  end

  def close(user)
    events.create!(state: "closed", user_id: user.id)
  end

  private

  def valid_dates
    errors.add(:end_date, 'must be after start') unless !self.end_date || self.start_date && self.end_date && self.end_date > self.start_date
  end

  def self.search(search)
    if search.present?
      where('projects.name ilike :q', q: "%#{search}%")
    else
      all
    end
  end

  def check_associations
    if !quotations.empty? ||
      !sales_orders.empty? ||
      !purchase_orders.empty?
      return false
    else
      return true
    end
  end

end
