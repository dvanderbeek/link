class MessageMailer < ActionMailer::Base
  default from: "noreply@linkcapital.com"

  def new_message(message)
    @message = message
    mail to: "info@linkcapital.com", 
         subject: "Link Capital Email Address Submission"
  end
end
