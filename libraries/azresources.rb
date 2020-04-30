# frozen_string_literal: true

require 'azbasic'

# AZ resoruces
class AzResources < AzBasic
  name 'azresources'
  def initialize(subcommand, resource_group = nil, extra_args = nil)
    super(subcommand, 'list', nil, resource_group, extra_args)
    @__resource_name__ = "#{@__resource_name__}: #{subcommand} #{resource_group}"
  end

  def exists
    count.positive?
  end

  def count
    @stdout.length
  end
end
