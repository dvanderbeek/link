class MessageMailer < ActionMailer::Base
  default from: "noreply@linkcapital.com"

  def new_message(message)
    @message = message
    mail to: "david.vanderbeek@linkcapital.com", 
         subject: "Link Capital Contact Form Submission"
  end
end
