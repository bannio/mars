class Event < ActiveRecord::Base
  # attr_accessible :eventable_id, :eventable_type, :state, :user_id
  belongs_to :eventable, polymorphic: true
  belongs_to :user

  after_save :update_eventable_status
 
  
   validates_inclusion_of :state, in: Quotation::STATES, if: :quotation?
   validates_inclusion_of :state, in: PurchaseOrder::STATES, if: :purchase_order?
   validates_inclusion_of :state, in: SalesOrder::STATES, if: :sales_order?

  
  def self.with_last_state(state)
    where("events.id in (SELECT MAX(events.id) FROM events GROUP BY eventable_id) AND state = '#{state}'")
  end
  
  private

  def quotation?
    eventable_type == 'Quotation'
  end

  def purchase_order?
    eventable_type == 'PurchaseOrder'
  end

  def sales_order?
    eventable_type == 'SalesOrder'
  end

  def update_eventable_status
    eventable.update_attributes(status: state)
  end
  
end
