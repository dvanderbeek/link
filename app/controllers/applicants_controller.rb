class ApplicantsController < ApplicationController
  before_filter :authenticate, only: :index

  def index
    @applicants = Applicant.order("created_at DESC")
  end

  def new
    @applicant = Applicant.new
  end

  def create
    @applicant = Applicant.new(params[:applicant])

    if @applicant.save
      ApplicantWorker.new.async.perform(@applicant)
      respond_to do |format|
        format.js
      end
    else
      respond_to do |format|
        format.js
      end
    end
  end

protected
  def authenticate
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV["ADMIN_USERNAME"] && password == ENV["ADMIN_PASSWORD"]
    end
  end
end
