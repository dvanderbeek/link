module ApplicationHelper
  def link_to_add_fields(name)
    fields = render("home/loan_fields")
    link_to(name, '#', class: "add_fields", data: {fields: fields.gsub("\n", "")})
  end
end
