module HomeHelper
  def nav_link(text, route, controller, action)
    content_tag :li, class: ("active" if params[:controller] == controller && params[:action] == action) do
      link_to text, route
    end
  end
end
