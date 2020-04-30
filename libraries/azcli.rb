# frozen_string_literal: true

# AZ CLI version
class AzCLI < AzBasic
  name 'azcli'

  def initialize
    super('version')
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
