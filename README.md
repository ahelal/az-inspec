
# inSpec AZ inspec resources

![Ruby](https://github.com/ahelal/az-inspec/workflows/Ruby/badge.svg)

This resource pack provides compliance for Azure using the az cli. Since the official pack is very slow to adapt to new resource.

## Prerequisites

You need [inSpec](https://www.inspec.io/downloads/)

## Usage
### Create a new profile

1. `$ inspec init profile my-profile`

```yaml
name: my-profile
title: test
version: 0.1.0
depends:
  - name: az-inspec
    url: https://github.com/ahelal/az-inspec/archive/master.tar.gz
```

2. Edit `inspec.yml` to reflect the dependency
3. Define your tests in `your_profile/control`

### Configuration for AZ credentials

You can use any of az-cli methods to login https://docs.microsoft.com/en-us/cli/azure/authenticate-azure-cli?view=azure-cli-latest

Simplest is to export an SPN variables as 
```bash
export AZURE_SUBSCRIPTION_ID='' 
export AZURE_CLIENT_ID=''
export AZURE_TENANT_ID=''
export AZURE_CLIENT_SECRET=''
```

**NOTE**: *whatever method you use, make sure your user has only read access to avoid any side effects.*

### Available resources

### azcli

Checks AZ info (versions, extensions, ....) equivalent to `az version -o json`

```ruby
describe azcli do
  its('exists') { should eq true }
  its('version') { should cmp > '2.0.75' }
  its('extensions') { should include 'aks-preview' }
end
```

### azaccount

```ruby
describe azaccount do
  its('name') { should eq 'SUB_NAME'}
end
```

### azaccounts

```ruby
describe azaccounts do
  its('count') { should eq 3}
end
```

### azresource

```ruby
describe azresource('vm', 'vm_name', 'rg') do
  its('exists') { should eq true }
  its(%w[tags env]) { should eq 'prod' }
  its('location') { should eq 'westus2' }
end

describe azresource('network vnet', 'vnetname', 'rg') do
  its('exists') { should eq true }
  its('location') { should eq 'eastus' }
  its(%w[addressSpace addressPrefixes]) { should include '192.168.0.0/16' }
end

describe azresource('network vnet subnet', 'subnet1', 'rg', '--vnet-name vnetname') do
  its('exists') { should eq true }
  its('addressPrefix') { should eq '192.168.1.0/24' }
end
```

### azresources

```ruby
describe azresources('vm') do
  its('exists') { should eq true }
  its('count') { should eq 4 }
end
```
