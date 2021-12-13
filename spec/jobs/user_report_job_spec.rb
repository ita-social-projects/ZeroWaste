require 'rails_helper'
require 'sidekiq/testing'
Sidekiq::Testing.fake!

RSpec.describe UserReportJob, type: :job do
  describe "#perform_later" do
    it "uploads a report" do
      ActiveJob::Base.queue_adapter = :test
      expect {
        UserReportJob.perform_later('report')
      }.to have_enqueued_job
    end
    it "uploads a report" do
      ActiveJob::Base.queue_adapter = :test
      expect {
        UserReportJob.set(wait_until: Date.tomorrow.noon, queue: "low").perform_later('report')
      }.to have_enqueued_job.with('report').on_queue("low").at(Date.tomorrow.noon)
    end
  end
end