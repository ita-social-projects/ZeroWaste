require "rails_helper"

RSpec.describe ConvertJsonToCsv do
  let(:input_file) { "spec/fixtures/files/unlighthouse_report.json" }
  let(:output_file) { "spec/fixtures/files/output.csv" }

  after do
    File.delete(output_file) if File.exist?(output_file)
  end

  describe ".perform" do
    it "converts JSON to CSV" do
      ConvertJsonToCsv.perform(input_file, output_file)
      csv_content = CSV.read(output_file, headers: true)

      expect(csv_content.headers).to eq(["path", "score", "performance", "accessibility", "best-practices", "seo"])

      expect(csv_content[0]["path"]).to eq("/en")
      expect(csv_content[0]["score"]).to eq("0.78")
      expect(csv_content[0]["performance"]).to eq("0.64")
      expect(csv_content[0]["accessibility"]).to eq("0.86")
      expect(csv_content[0]["best-practices"]).to eq("0.79")
      expect(csv_content[0]["seo"]).to eq("0.83")
    end
  end
end
