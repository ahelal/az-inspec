# frozen_string_literal: true

require 'inspec'
require_relative 'spec_helper'
require_relative '../libraries/azcli'

RSpec.describe 'Azcli' do
  context 'version' do
    before(:example) do
      ENV['AZCLI_BIN'] = "#{__dir__}/azmock.rb"
    end
    it 'it should exists' do
      @az = AzCLI.new
      expect(@az.exists).to eq(true)
      expect(@az.success).to eq(true)
      expect(@az.version).to eq('2.0.81')
      expect(@az.extensions).to include('aks-preview')
    end
  end
end
