require 'rails_helper'

RSpec.describe Field, type: :model do
subject(:field) { build(:field) } 

  describe "validations" do
    it { should validate_presence_of(:uuid) }
    it { should validate_presence_of(:type) }
    it { should validate_presence_of(:selector) }
    it { should validate_presence_of(:kind) }
  end
  describe "associations" do
    it { should belong_to(:calculator) }
  end  
end
