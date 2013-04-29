class Event < ActiveRecord::Base
  # attr_accessible :eventable_id, :eventable_type, :state, :user_id
  belongs_to :eventable, polymorphic: true
 
  
  validates_inclusion_of :state, in: Quotation::STATES
  
  # def self.with_last_state(state)
  #   order("id desc").group(eventable_id).having(state: state)
  # end
  
  def self.with_last_state(state)
    where("events.id in (SELECT MAX(events.id) FROM events GROUP BY eventable_id) AND state = '#{state}'")
  end
  
  private
  
end
