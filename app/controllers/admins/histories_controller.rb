# frozen_string_literal: true

module Admins
  class HistoriesController < ApplicationController
    def index
      @versions = PaperTrail::Version.order('created_at DESC').limit(100)
    end
  end
end
