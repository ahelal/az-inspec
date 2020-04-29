# frozen_string_literal: true

require_relative 'azbasic'

# AZ single resoruce
class AzResource < AzBasic
  name 'azresource'
  def initialize(subcommand, resource_name, resource_group)
    super(subcommand, 'show', resource_name, resource_group)
    @__resource_name__ = "#{@__resource_name__}: #{subcommand} #{resource_name}/#{resource_group}"
  end
end
