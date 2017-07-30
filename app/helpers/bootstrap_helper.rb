module BootstrapHelper
  def icon(*names)
    content_tag(:i, nil, class: icon_classes(names))
  end

  def material_icon(name)
    content_tag(:i, name.to_s, class: "material-icons md-18 md-dark")
  end

  private
  def icon_classes(*names)
    names[0].map{|name| "icon-#{name}"}
  end
end