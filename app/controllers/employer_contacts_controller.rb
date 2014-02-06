class EmployerContactsController < ApplicationController
  def create
    @employer_contact = EmployerContact.new(params[:employer_contact])

    respond_to do |format|
      if @employer_contact.valid?
        EmployerContactWorker.new.async.perform(@employer_contact)
        format.html { redirect_to root_url, notice: "Thank you for contacting us!  Your message was sent and we will get back to you as soon as possible." }
        format.js
      else
        format.html { render "new" }
        format.js
      end
    end
  end
end