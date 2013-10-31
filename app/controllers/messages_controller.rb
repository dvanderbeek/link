class MessagesController < ApplicationController
  def new
    @message = Message.new
  end

  def create
    @message = Message.new(params[:message])

    respond_to do |format|
      if @message.valid?
        MessageWorker.new.async.perform(@message)
        format.html { redirect_to root_url, notice: "Thank you for contacting us!  Your message was sent and we will get back to you as soon as possible." }
        format.js
      else
        format.html { render "new" }
        format.js
      end
    end
  end
end