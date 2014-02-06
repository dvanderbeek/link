class ApplicantWorker
  include SuckerPunch::Job
  include ActionView::Helpers::NumberHelper

  def perform(applicant)
    message = <<-EOF
      Name: #{applicant.name} \r\n
      Email: #{applicant.email} \r\n
      Phone: #{applicant.phone.nil? ? 'N/A' : applicant.phone} \r\n
      School: #{applicant.school.nil? ? 'N/A' : applicant.school} \r\n
      Employer: #{applicant.employer.nil? ? 'N/A' : applicant.employer} \r\n
      Outstanding Balance: #{applicant.balance.nil? ? 'N/A' : number_to_currency(applicant.balance)}
    EOF

    client = UserVoice::Client.new(ENV['USERVOICE_API_SUBDOMAIN'], ENV['USERVOICE_API_KEY'], ENV['USERVOICE_API_SECRET'], :callback => ENV['USERVOICE_API_CALLBACK'])
    @sdk_question = client.post("/api/v1/tickets.json", {
      :email => applicant.email,
      :name => applicant.name,
      :ticket => {
        :subject => 'Application Submitted',
        :message => message
      }
    })['ticket']
  end
end