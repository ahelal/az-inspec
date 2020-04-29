# frozen_string_literal: true

require_relative 'run'

# AZ CLI version
class AzCli < Inspec.resource(1)
  name 'az'
  def initialize
    @stdout, @stderr, @success = run_cmd('az version', true)
    raise Inspec::Exceptions::ResourceSkipped, "AZ CLI: #{@stderr}" unless @success
  end

  def exists
    @success
  end

  def version
    @stdout['azure-cli'] if @success
  end

  def extensions
    @stdout['extensions'] if @success
  end
end
