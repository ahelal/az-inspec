# frozen_string_literal: true

require 'inspec/utils/object_traversal'
require 'open3'
require 'json'

# AZ basic class
class AzBasic < Inspec.resource(1)
  name 'az_basic'
  desc 'Baisc parent resource should not be used directly'
  attr_reader :stdout, :stderr, :success
  include ObjectTraverser
  def initialize(subcommand, list = nil, resource_name = nil, resource_group = nil, extra_args = nil)
    raise Inspec::Exceptions::ResourceFailed, "A resource is needed. Can't be empty" if subcommand.to_s.length.zero?

    # TODO: disable any main commands
    # ['configure', 'feedback', 'find', 'interactive', 'login', 'logout', 'rest']
    azbin = ENV['AZCLI_BIN'] || 'az'
    command = "#{azbin} #{subcommand} #{list}"
    command = "#{command} --name #{resource_name}" if resource_name
    command = "#{command} --resource-group #{resource_group}" if resource_group
    command = "#{command} #{extra_args}" if extra_args
    command = "#{command} -o json"
    @stdout, @stderr, @success = azrun(command)
  end

  def exists
    return true if !@stdout.nil? && @success

    false
  end

  def method_missing(*keys)
    raise Inspec::Exceptions::ResourceSkipped, "AZ CLI: #{@stderr}" unless @success

    # catch bahavior of rspec its implementation
    # @see https://github.com/rspec/rspec-its/blob/master/lib/rspec/its.rb#L110
    keys.shift if keys.is_a?(Array) && keys[0] == :[]
    value(keys)
  end

  def value(key)
    # uses ObjectTraverser.extract_value to walk the hash looking for the key,
    # which may be an Array of keys for a nested Hash.
    extract_value(key, @stdout)
  end

  private

  def azrun(cmd)
    stdout, stderr, s = Open3.capture3(cmd)
    # return [nil, 'not found', s.success?] if !s.success? && stdout.include?('was not found')

    stdout = JSON.parse(stdout) if s.success?
    [stdout, stderr, s.success?]
  rescue JSON::ParserError
    [stdout, stderr, s.success?]
  rescue Errno::ENOENT => e
    raise Inspec::Exceptions::ResourceFailed, "AZ CLI: #{e}"
    # rescue StandardError => e
    # raise Inspec::Exceptions::ResourceSkipped, "AZ CLI: #{e}"
  end
end
