require 'rails_helper'

RSpec.describe "calculators/calculator" do
  before do
    allow(view).to receive(:user_signed_in?).and_return(true)
  end
  
  it "checks for user signning in" do
    render
    expect(rendered).to match /Yes, I want to receive email messages/
  end
  
  it "inhers the calculators path" do
    expect(controller.controller_path).to eq("calculators")
  end

  it "inhers the controller action" do
    expect(controller.request.path_parameters[:action]).to eq("calculator")
  end
end
