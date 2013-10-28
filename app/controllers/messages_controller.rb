class MessagesController < ApplicationController
  def new
    @message = Message.new
  end

  def create
    @message = Message.new(params[:message])

    respond_to do |format|
      if @message.valid?
        # MessageMailer.new_message(@message).deliver

        # Create a ticket in UserVoice
        client = UserVoice::Client.new(ENV['USERVOICE_API_SUBDOMAIN'], ENV['USERVOICE_API_KEY'], ENV['USERVOICE_API_SECRET'], :callback => ENV['USERVOICE_API_CALLBACK'])
        @sdk_question = client.post("/api/v1/tickets.json", {
          :email => @message.email,
          :name => @message.name,
          :ticket => {
            :subject => 'Contact Us Submission',
            :message => (@message.content + (@message.phone.blank? ? "" : (" Phone: " + @message.phone)))
          }
        })['ticket']

        format.html { redirect_to root_url, notice: "Message sent! Thank you for contacting us; we will get back to you as soon as possible." }
        format.js
      else
        format.html { render "new" }
        format.js
      end
    end
  end
end