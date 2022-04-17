# frozen_string_literal: true

module Api
  module V1
    class DiaperCalculatorsController < ApplicationController
      VALUES = [
        { name: 'money_spent', result: 7841 },
        { name: 'money_will_be_spent', result: 342 }
      ].freeze

      def create
        render(json: { result: VALUES, date: params[:childs_birthday] })
      end
    end
  end
end
