# frozen_string_literal: true

require_relative 'azbasic'

# AZ single resoruce
class AzResources < AzBasic
  name 'azresources'
  def initialize(subcommand, resource_group = nil)
    super(subcommand, 'list', nil, resource_group)
    @__resource_name__ = "#{@__resource_name__}: #{subcommand} #{resource_group}"
  end

  def exists
    count.positive?
  end

  def count
    @stdout.length
  end
end
