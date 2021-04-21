require 'rails_helper'

RSpec.describe Calculator, type: :view do
  describe "rendering text directly" do
    it "displays the given text" do  
      render :calculator => "This is directly rendered"  
      rendered.should contain("directly rendered")
    end
  end
end
