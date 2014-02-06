class EmployerContactWorker
  include SuckerPunch::Job

  def perform(contact)

    message = <<-EOF
      Name: #{contact.name} \r\n
      Employer: #{contact.employer} \r\n
      Position: #{contact.position} \r\n
      Email: #{contact.email} \r\n
      Phone: #{contact.phone}
    EOF

    client = UserVoice::Client.new(ENV['USERVOICE_API_SUBDOMAIN'], ENV['USERVOICE_API_KEY'], ENV['USERVOICE_API_SECRET'], :callback => ENV['USERVOICE_API_CALLBACK'])
    @sdk_question = client.post("/api/v1/tickets.json", {
      :email => contact.email,
      :name => contact.name,
      :ticket => {
        :subject => 'Employer Contact Submission',
        :message => message
      }
    })['ticket']
  end
end