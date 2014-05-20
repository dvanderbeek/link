class MessageWorker
  include SuckerPunch::Job

  def perform(message)
    if message.content.present?
      client = UserVoice::Client.new(ENV['USERVOICE_API_SUBDOMAIN'], ENV['USERVOICE_API_KEY'], ENV['USERVOICE_API_SECRET'], :callback => ENV['USERVOICE_API_CALLBACK'])
      @sdk_question = client.post("/api/v1/tickets.json", {
        :email => message.email,
        :name => message.name,
        :ticket => {
          :subject => 'Contact Us Submission',
          :message => (message.content + (message.phone.blank? ? "" : (" Phone: " + message.phone)))
        }
      })['ticket']
    else
      MessageMailer.new_message(message).deliver
    end
  end
end