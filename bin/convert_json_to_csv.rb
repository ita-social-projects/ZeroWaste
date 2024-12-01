#!/usr/bin/env ruby
require_relative "../lib/convert_json_to_csv"

input_file  = ARGV[0]
output_file = ARGV[1]
ConvertJsonToCsv.perform(input_file, output_file)
