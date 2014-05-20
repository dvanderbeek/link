class MessageMailer < ActionMailer::Base
  default from: "noreply@linkcapital.com"

  def new_message(message)
    @message = message
    mail to: "earlynovrock@gmail.com", 
         subject: "Link Capital Email Address Submission"
  end
end
