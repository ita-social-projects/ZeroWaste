# frozen_string_literal: true

class UserReportJob < ApplicationJob
  queue_as :default
  def perform(*args); end
end
