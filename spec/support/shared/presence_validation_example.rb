shared_examples "presence validation" do |attribute|
  it "#{attribute} is valid when present" do
    validator.send(:"validate_#{attribute}")

    expect(validator.errors[attribute]).to be_nil
  end

  context "#{attribute} is not present" do
    before do
      validator.params[attribute] = nil
    end

    it "#{attribute} is invalid when blank" do
      validator.send(:"validate_#{attribute}")

      expect(validator.errors[attribute]).to eq(I18n.t("#{local_error_prefix}.presence_error_msg", field: I18n.t("#{local_field_prefix}.#{attribute}")))
    end
  end
end

shared_examples "length validation" do |attribute, from, to|
  it "#{attribute} is valid when in the proper range" do
    validator.send(:"validate_#{attribute}")

    expect(validator.errors[attribute]).to be_nil
  end

  context "#{attribute} is not in range" do
    it "#{attribute} is invalid when less than from" do
      validator.params[attribute] = from - 1

      validator.send(:"validate_#{attribute}")

      expect(validator.errors[attribute]).to eq(I18n.t("#{local_error_prefix}.length_error_msg", field: I18n.t("#{local_field_prefix}.#{attribute}"), from: from, to: to))
    end

    it "#{attribute} is invalid when bigger than to" do
      validator.params[attribute] = to + 1

      validator.send(:"validate_#{attribute}")

      expect(validator.errors[attribute]).to eq(I18n.t("#{local_error_prefix}.length_error_msg", field: I18n.t("#{local_field_prefix}.#{attribute}"), from: from, to: to))
    end
  end
end

shared_examples "pad category validation" do |attribute|
  it "#{attribute} is valid when present" do
    validator.send(:"validate_#{attribute}")

    expect(validator.errors[attribute]).to be_nil
  end

  context "#{attribute} is not present" do
    before do
      validator.params[attribute] = nil
    end

    it "#{attribute} is invalid when blank" do
      validator.send(:"validate_#{attribute}")

      expect(validator.errors[attribute]).to eq(I18n.t("#{local_error_prefix}.presence_error_msg", field: I18n.t("#{local_field_prefix}.#{attribute}")))
    end
  end

  context "#{attribute} is not a valid category" do
    before do
      validator.params[attribute] = "invalid_category"
    end

    it "#{attribute} is invalid when not a valid category" do
      validator.send(:"validate_#{attribute}")

      expect(validator.errors[attribute]).to eq(I18n.t("#{local_error_prefix}.wrong_category_error_msg"))
    end
  end
end

shared_examples "product type validation" do |attribute|
  before do
    validator.params[attribute] = "invalid_type"
  end

  it "#{attribute} is invalid when not a valid product type" do
    validator.send(:"validate_#{attribute}")

    expect(validator.errors[attribute]).to eq(I18n.t("#{local_error_prefix}.type_error_msg"))
  end
end
