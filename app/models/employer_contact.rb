class EmployerContact
  include ActiveAttr::Model
  
  attribute :name
  attribute :email
  attribute :phone
  attribute :employer
  attribute :position # type: Integer, default: 0
  
  # attr_accessible :name, :email, :content

  validates_presence_of :name, :email, :phone, :employer, :position
  validates_format_of :email, :with => /^[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}$/i
end