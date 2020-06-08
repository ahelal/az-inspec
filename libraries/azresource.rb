# frozen_string_literal: true

# AZ single resoruce
class AzResource < AzBasic
  name 'azresource'
  def initialize(subcommand, resource_name, resource_group = nil, extra_args = nil, subscription = nil)
    super(subcommand, 'show', resource_name, resource_group, extra_args, subscription)
    @__resource_name__ = "#{@__resource_name__}: #{subcommand} -n #{resource_name}"
    @__resource_name__ = "#{@__resource_name__} -g #{resource_group}" if resource_group
  end
end
