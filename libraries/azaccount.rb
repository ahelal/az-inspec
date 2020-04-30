# frozen_string_literal: true

require 'azbasic'

# AZ account
class AzAccount < AzBasic
  name 'azaccount'
  desc 'Azure current account info'

  def initialize
    super('account', 'show')
  end

  def exists
    @success
  end
end

# AZ accounts
class AzAccounts < AzBasic
  name 'azaccounts'
  desc 'Azure list of accounts'

  def initialize
    super('account', 'list')
  end

  def exists
    count.positive?
  end

  def count
    @stdout.length
  end
end
