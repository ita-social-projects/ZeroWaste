shared_examples "presence validation" do |attribute|
  it "#{attribute} is valid when present" do
    expect(validator.send(:"validate_#{attribute}")).to be true
    expect(validator.errors[attribute]).to be_nil
  end

  context "#{attribute} is not present" do
    before do
      validator.params[attribute] = nil
    end

    it "#{attribute} is invalid when blank" do
      expect(validator.send(:"validate_#{attribute}")).to be false
      expect(validator.errors[attribute]).to eq(I18n.t("#{local_error_prefix}.presence_error_msg", field: I18n.t("#{local_field_prefix}.#{attribute}")))
    end
  end
end
