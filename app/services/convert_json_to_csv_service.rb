class ConvertJsonToCsvService
  def self.call(input_file, output_file)
    new(input_file, output_file).call
  end

  def initialize(input_file, output_file)
    @input_file  = input_file
    @output_file = output_file
  end

  def call
    json_data = JSON.parse(File.read(@input_file))

    CSV.open(@output_file, "w", write_headers: true, headers: json_data.first.keys) do |csv|
      json_data.each { |row| csv << row.values }
    end
    @output_file
  end
end
