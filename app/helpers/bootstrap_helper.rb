module BootstrapHelper
  def icon(*names)
    content_tag(:i, nil, class: icon_classes(names))
  end

  private
  def icon_classes(*names)
    names[0].map{|name| "icon-#{name}"}
  end
end