# frozen_string_literal: true

require 'inspec'
require_relative 'spec_helper'
require_relative '../libraries/azresource'
require_relative '../libraries/azresources'

RSpec.describe 'Azresource' do
  context 'resource' do
    before(:example) do
      ENV['AZCLI_BIN'] = "#{__dir__}/azmock.rb"
    end
    it 'it should exists' do
      @az = AzResource.new('vm', 'name', 'rg')
      expect(@az.exists).to eq(true)
      expect(@az.success).to eq(true)
      expect(@az.name).to eq('1')
      expect(@az.stderr).to eq('')
    end
  end
  context 'resources' do
    before(:example) do
      ENV['AZCLI_BIN'] = "#{__dir__}/azmock.rb"
    end
    it 'it should exists' do
      @az = AzResources.new('vm', 'rg')
      expect(@az.stderr).to eq('')
      expect(@az.exists).to eq(true)
      expect(@az.success).to eq(true)
      expect(@az.count).to eq(2)
      expect(@az[0]['name']).to eq('1')
      expect(@az[1]['name']).to eq('2')
    end
  end
end
