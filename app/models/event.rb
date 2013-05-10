class Event < ActiveRecord::Base
  # attr_accessible :eventable_id, :eventable_type, :state, :user_id
  belongs_to :eventable, polymorphic: true
 
  
   validates_inclusion_of :state, in: Quotation::STATES, if: :quotation?
  

  
  def self.with_last_state(state)
    where("events.id in (SELECT MAX(events.id) FROM events GROUP BY eventable_id) AND state = '#{state}'")
  end
  
  private

  def quotation?
    eventable_type == 'Quotation'
  end
  
end
