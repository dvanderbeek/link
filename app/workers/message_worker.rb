class MessageWorker
  include SuckerPunch::Job

  def perform(message)
    ActiveRecord::Base.connection_pool.with_connection do
      client = UserVoice::Client.new(ENV['USERVOICE_API_SUBDOMAIN'], ENV['USERVOICE_API_KEY'], ENV['USERVOICE_API_SECRET'], :callback => ENV['USERVOICE_API_CALLBACK'])
      @sdk_question = client.post("/api/v1/tickets.json", {
        :email => message.email,
        :name => message.name,
        :ticket => {
          :subject => 'Contact Us Submission',
          :message => (message.content + (message.phone.blank? ? "" : (" Phone: " + message.phone)))
        }
      })['ticket']
      # PrivatePub.publish_to("/messages/new", "alert('Support ticket received!');")
    end
  end
end