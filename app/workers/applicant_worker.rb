class ApplicantWorker
  include SuckerPunch::Job
  include ActionView::Helpers::NumberHelper

  def perform(applicant)
    message = <<-EOF
      Name: #{applicant.name} \r\n
      Email: #{applicant.email} \r\n
      School: #{applicant.school} \r\n
      Balance: #{number_to_currency applicant.balance} \r\n
      Rate: #{number_to_percentage applicant.rate} \r\n
      Referred By: #{applicant.referred_by.nil? ? 'N/A' : applicant.referred_by}
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