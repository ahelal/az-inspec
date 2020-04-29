# frozen_string_literal: true

require 'open3'
require 'json'

def run_cmd(cmd, json_out = true)
  stdout, stderr, s = Open3.capture3(cmd)
  stdout = JSON.parse(stdout) if s.success? && json_out
  [stdout, stderr, s.success?]
rescue StandardError => e
  raise Inspec::Exceptions::ResourceSkipped, "AZ CLI: #{e}"
end
