class SalesLink < ActiveRecord::Base
  belongs_to :purchase_order_line
  belongs_to :sales_order_line
  # attr_accessible :title, :body
end
