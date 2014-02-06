class Applicant < ActiveRecord::Base
  attr_accessible :balance, :email, :phone, :employer, :name, :rate, :school, :referred_by
  validates_presence_of :email, :name
  validates_format_of :email, :with => /^[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}$/i
end
