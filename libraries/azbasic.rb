# frozen_string_literal: true

require 'inspec/utils/object_traversal'

# AZ CLI version
class AzBasic < Inspec.resource(1)
  name 'az_basic'

  include ObjectTraverser
  def initialize(subcommand, list, resource_name = nil, resource_group = nil)
    raise Inspec::Exceptions::ResourceFailed, "a type of resource is needed. Can't be empty" if subcommand.to_s.length.zero?

    command = "az #{subcommand} #{list}"
    command = "#{command} --name #{resource_name}" if resource_name
    command = "#{command} --resource-group #{resource_group}" if resource_group
    @stdout, @stderr, @success = run_cmd(command, true)
  end

  def exists
    !@stdout.nil? && @success
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
end
