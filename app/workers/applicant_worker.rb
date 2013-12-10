class ApplicantWorker
  include SuckerPunch::Job

  def perform(applicant)
    client = UserVoice::Client.new(ENV['USERVOICE_API_SUBDOMAIN'], ENV['USERVOICE_API_KEY'], ENV['USERVOICE_API_SECRET'], :callback => ENV['USERVOICE_API_CALLBACK'])
    @sdk_question = client.post("/api/v1/tickets.json", {
      :email => applicant.email,
      :name => applicant.name,
      :ticket => {
        :subject => 'Application Submitted',
        :message => ("Name: " + applicant.name + ", Email: " + applicant.email + "School: " + applicant.school + ", Balance: " + applicant.balance.to_s + ", Rate: " + applicant.rate.to_s)
      }
    })['ticket']
  end
end