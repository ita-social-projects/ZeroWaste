require "rails_helper"

RSpec.describe ConvertJsonToCsvService do
  let(:input_file) { "spec/fixtures/files/unlighthouse_report.json" }
  let(:output_file) { "spec/fixtures/files/output.csv" }
  let(:csv_content) { CSV.read(output_file, headers: true) }
  let(:service) { described_class.call(input_file, output_file) }

  describe ".call" do
    context "when initializing and calling an instance" do
      let(:service_instance) { instance_double(ConvertJsonToCsvService) }

      before do
        allow(ConvertJsonToCsvService).to receive(:new).with(input_file, output_file).and_return(service_instance)
        allow(service_instance).to receive(:call).and_return(output_file)
      end

      it "initializes and calls the instance with the provided arguments" do
        result = service

        expect(ConvertJsonToCsvService).to have_received(:new).with(input_file, output_file)
        expect(service_instance).to have_received(:call)
        expect(result).to eq(output_file)
      end
    end

    context "when creating a CSV file" do
      it "creates a csv file with correct data" do
        result = service

        expect(result).to eq(output_file)
        expect(File.exist?(output_file)).to be_truthy
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
end
