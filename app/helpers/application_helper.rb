module ApplicationHelper

	 def sortable(column, title = nil)
    title ||= column.titleize
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    # link_to title, params.merge(sort: column, direction: direction)
    params = {sort: column, direction: direction}
    link_to title, params.merge(sort_params)
  end

  def arrow(column)
    direction = sort_direction == "desc" ? "down" : "up"
    icon = column == sort_column ? "icon-chevron-#{direction}" : nil
    arrow = '<i class="' << "#{icon}" << '"></i>'
    arrow = raw(arrow)
  end

  def delivery_addresses(po)
    delivery_addresses = po.client.addresses + po.customer.addresses
  end

  def sort_params
    params.permit(:sort, :direction)
  end
end
