require 'rails_helper'


RSpec.describe UserReportJob, type: :job do
  describe '#perform_later' do
    let(:job_report) { UserReportJob.perform_later('report') }
    let(:job_with_date) do 
      UserReportJob
        .set(wait_until: Date.tomorrow.noon, queue: 'low')
        .perform_later('report') 
    end

    it 'uploads a report' do 
     expect { job_report }.to have_enqueued_job
    end

    it 'uploads a report' do
      expect{ job_with_date }.to have_enqueued_job
        .with('report').on_queue('low').at(Date.tomorrow.noon)
    end
  end
end
