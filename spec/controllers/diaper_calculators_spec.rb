# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::DiaperCalculatorsController do
  describe "#create" do

    let (:values) {}

    context "default values" do

      let (:values){[
        { name: 'money_spent', result: 0 },
        { name: 'money_will_be_spent', result: 0 },
        { name: 'used_diapers_amount', result: 0 },
        { name: 'to_be_used_diapers_amount', result: 0 }
      ]}

      it "renders" do
        @expected = {
        :result  =>  values,
        :date    => 0,
        :word_form   => 'підгузків'
          }.to_json
        get :create
        response.body.should == @expected
      end
    end
  end
end
