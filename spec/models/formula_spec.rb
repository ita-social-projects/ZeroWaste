# == Schema Information
#
# Table name: formulas
#
#  id            :bigint           not null, primary key
#  en_label      :string           default(""), not null
#  en_unit       :string
#  expression    :string           default(""), not null
#  priority      :integer          default(0), not null
#  uk_label      :string           default(""), not null
#  uk_unit       :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  calculator_id :bigint           not null
#
# Indexes
#
#  index_formulas_on_calculator_id  (calculator_id)
#
# Foreign Keys
#
#  fk_rails_...  (calculator_id => calculators.id)
#
require "rails_helper"

RSpec.describe Formula, type: :model do
  let(:local_prefix_formula) { "activerecord.errors.models.formula.attributes" }
  let(:calculator) { create(:calculator) }
  let!(:formula) { build(:formula, expression: "a + b", calculator: calculator) }

  describe "validations" do
    it { is_expected.to validate_presence_of(:uk_label) }
    it { is_expected.to validate_length_of(:uk_label).is_at_least(3).is_at_most(50) }
    it { is_expected.to validate_presence_of(:en_label) }
    it { is_expected.to validate_length_of(:en_label).is_at_least(3).is_at_most(50) }
    it { is_expected.to validate_presence_of(:uk_unit) }
    it { is_expected.to validate_length_of(:uk_unit).is_at_least(1).is_at_most(30) }
    it { is_expected.to validate_presence_of(:en_unit) }
    it { is_expected.to validate_length_of(:en_unit).is_at_least(1).is_at_most(30) }
    it { is_expected.to validate_presence_of(:expression) }

    context "formula has all fields initialized" do
      before do
        calculator.fields.build(var_name: "a")
        calculator.fields.build(var_name: "b")
      end

      it "is valid" do
        expect(formula).to be_valid
      end
    end

    context "formula has some fields not initialized" do
      it "is invalid" do
        expect(formula).not_to be_valid
        expect(formula.errors[:expression]).to include(I18n.t("#{local_prefix_formula}.expression.uninitialized_fields", fields: "a, b", count: 2))
      end
    end

    it "formula is mathematically invalid" do
      formula.expression = "a + b b"

      expect(formula).to_not be_valid
      expect(formula.errors[:expression]).to include(I18n.t("#{local_prefix_formula}.expression.mathematically_invalid"))
    end
  end

  describe "associations" do
    it { is_expected.to belong_to(:calculator) }
    it { is_expected.to have_one_attached(:formula_image) }
  end

  describe "attachments" do
    it "can attach a formula_image" do
      formula.formula_image.attach(io: Rails.root.join("spec", "fixtures", "icons", "favicon-181x182.png").open, filename: "favicon-181x182.png")

      expect(formula.formula_image).to be_attached
      expect(formula.formula_image.filename.to_s).to eq("favicon-181x182.png")
    end

    it "can't attach not PNG or JPNG image to formula_image" do
      webp_content = "Some data"
      webp_file    = Tempfile.new(["test_type", ".webp"])
      webp_file.write(webp_content)

      formula.formula_image.attach(
        io: webp_file,
        filename: "test_type.webp",
        content_type: "image/webp"
      )

      expect(formula).to_not be_valid
      expect(formula.errors[:formula_image]).to include(I18n.t("#{local_prefix_formula}.formula_image.image_type_invalid"))
    end

    it "can't attach image with more that 2MB to formula_image" do
      large_file_content = "A" * (2.megabytes + 1)
      large_file         = Tempfile.new("large_image.png")
      large_file.write(large_file_content)

      formula.formula_image.attach(
        io: large_file,
        filename: "large_image.png",
        content_type: "image/png"
      )

      expect(formula).to_not be_valid
      expect(formula.errors[:formula_image]).to include(I18n.t("#{local_prefix_formula}.formula_image.image_size_invalid"))
    end

    it "returns false if no formula_image is attached" do
      formula.save
      expect(formula.formula_image.attached?).to eq(false)
    end
  end
end
