# frozen_string_literal: true

require 'inspec'
require_relative 'spec_helper'
require_relative '../libraries/azaccount'

RSpec.describe 'AzAccount' do
  context 'account' do
    before(:example) do
      ENV['AZCLI_BIN'] = "#{__dir__}/azmock.rb"
    end
    it 'it should exists' do
      @az = AzAccount.new
      expect(@az.exists).to eq(true)
      expect(@az.success).to eq(true)
      expect(@az.name).to eq('1')
      expect(@az.stderr).to eq('')
    end
  end
  context 'accounts' do
    before(:example) do
      ENV['AZCLI_BIN'] = "#{__dir__}/azmock.rb"
    end
    it 'it should exists' do
      @az = AzAccounts.new
      expect(@az.exists).to eq(true)
      expect(@az.success).to eq(true)
      expect(@az.count).to eq(2)
      expect(@az.stderr).to eq('')
    end
  end
end
