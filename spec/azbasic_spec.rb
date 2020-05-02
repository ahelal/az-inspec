# frozen_string_literal: true

require 'inspec'
require_relative 'spec_helper'
require_relative '../libraries/azbasic'

RSpec.describe 'Az basic class' do
  context 'misconfigured' do
    before(:example) do
      ENV['AZCLI_BIN'] = "#{__dir__}/noazcli"
    end
    it 'when no argument, it raises error' do
      expect { AzBasic.new }.to raise_error(ArgumentError)
    end
    it 'when wrong path, it raises error' do
      expect { AzBasic.new('1') }.to raise_error(Inspec::Exceptions::ResourceFailed)
    end
  end

  context 'subcommand' do
    before(:example) do
      ENV['AZCLI_BIN'] = "#{__dir__}/azmock.rb"
    end
    it 'when exists, it should successed' do
      @az = AzBasic.new('version')
      expect(@az.exists).to eq(true)
      expect(@az.success).to eq(true)
    end
    it 'when does not exists, it should fail' do
      @az = AzBasic.new('non')
      expect(@az.exists).to eq(false)
      expect(@az.success).to eq(false)
    end
    it 'when unknown metho called, it should return nil' do
      @az = AzBasic.new('version')
      expect(@az.exists).to eq(true)
      expect(@az.success).to eq(true)
      expect(@az.noops).to eq(nil)
    end
    it 'when complex data model, it should successed' do
      @az = AzBasic.new('complex')
      expect(@az.exists).to eq(true)
      expect(@az.success).to eq(true)
      expect(@az['str']).to eq('str')
      expect(@az['bool']).to eq(true)
      expect(@az['array']).to eq([1, 2])
      expect(@az['object'][0]['a']).to eq(1)
      expect(@az['object'][0]['b']).to eq(true)
    end
  end

  context 'run output' do
    before(:example) do
      ENV['AZCLI_BIN'] = "#{__dir__}/azmock.rb"
    end
    it 'stdout and stderr should be captured' do
      @az = AzBasic.new('output')
      expect(@az.exists).to eq(true)
      expect(@az.success).to eq(true)
      expect(@az.stdout).to cmp({ 'stdout' => true })
      expect(@az.stderr).to cmp("stderr\n")
    end
    it 'stdout and stderr should be captured' do
      @az = AzBasic.new('echo', 'list', 'resource_name', 'resource_group', 'extra_args')
      expect(@az.exists).to eq(true)
      expect(@az.success).to eq(true)
      expect(@az.stdout).to cmp("echo list --name resource_name --resource-group resource_group extra_args -o json\n")
    end
  end
end
