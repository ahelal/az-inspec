#!/usr/bin/env ruby
# frozen_string_literal: true

require 'json'

stdout = { 'stdout' => true }
stderr = 'stderr'
version = { 'azure-cli' => '2.0.81', 'json-value' => true, 'extensions' => { 'aks-preview' => '0.4.43' } }
complex = { 'str' => 'str', 'bool': true, 'array' => [1, 2], 'object': ['a' => 1, 'b' => true] }
accounts = [{ 'name' => '1' }, { 'name' => '2' }]
account = accounts[0]
vms = accounts
vm = vms[0]

case ARGV[0]
when 'version'
  puts version.to_json
when 'output'
  puts stdout.to_json
  warn stderr
when 'complex'
  puts complex.to_json
when 'echo'
  puts ARGV.join(' ')
when 'vm'
  if ARGV == ['vm', 'show', '--name', 'name', '--resource-group', 'rg', '-o', 'json']
    puts vm.to_json
  elsif ARGV == ['vm', 'list', '--resource-group', 'rg', '-o', 'json']
    puts vms.to_json
  else
    abort "Error vm: unknown argument #{ARGV}"
  end
when 'account'
  if ARGV == ['account', 'show', '-o', 'json']
    puts account.to_json
  elsif ARGV == ['account', 'list', '-o', 'json']
    puts accounts.to_json
  else
    abort "Error account: unknown argument #{ARGV}"
  end
else
  abort "Error: unknown argument #{ARGV}"
end
