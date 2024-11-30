require "json"
require "csv"

class ConvertJsonToCsv
  def self.perform(input_file, output_file)
    json_data = JSON.parse(File.read(input_file))
    CSV.open(output_file, "w", write_headers: true, headers: json_data.first.keys) do |csv|
      json_data.each { |row| csv << row.values }
    end
  end
end

if __FILE__ == $0
  input_file  = ARGV[0]
  output_file = ARGV[1]
  ConvertJsonToCsv.perform(input_file, output_file)
end
