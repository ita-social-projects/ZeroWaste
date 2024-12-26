require "rails_helper"

RSpec.describe ApplicationHelper, type: :helper do
  describe "#current_locale?" do
    context "when the current locale matches the given locale" do
      it "returns true" do
        I18n.with_locale(:en) do
          expect(helper.current_locale?(:en)).to be true
        end
      end
    end

    context "when the current locale does not match the given locale" do
      it "returns false" do
        I18n.with_locale(:en) do
          expect(helper.current_locale?(:uk)).to be false
        end
      end
    end
  end
end
