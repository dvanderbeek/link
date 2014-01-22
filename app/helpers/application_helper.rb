module ApplicationHelper
  def link_to_add_fields(name)
    fields = render("home/loan_fields")
    link_to(name, '#', class: "add_fields", data: {fields: fields.gsub("\n", "")})
  end

  def fixed_terms
    %w[3 5 7 10 15 20 30]
  end

  def variable_terms
    %w[5 10]
  end
end
