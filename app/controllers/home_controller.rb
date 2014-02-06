class HomeController < ApplicationController
  def index
  end

  def students
  end

  def investors
  end

  def organizations
    @employer_contact = EmployerContact.new()
  end

  def about_us
  end

  def privacy_policy
  end
end
