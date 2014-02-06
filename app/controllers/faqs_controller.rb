class FaqsController < ApplicationController
  def index
    client = UserVoice::Client.new(ENV['USERVOICE_API_SUBDOMAIN'], ENV['USERVOICE_API_KEY'], ENV['USERVOICE_API_SECRET'], :callback => 'http://linkcapital.herokuapp.com/')
    @faqs = client.get("/api/v1/articles.json?per_page=100")

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @faqs }
      format.js
    end
  end
end
