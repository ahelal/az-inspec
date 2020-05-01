# frozen_string_literal: true

describe azcli do
  its('exists') { should eq true }
  its('version') { should eq '2.0.81' }
  its('version') { should cmp > '2.0.75' }
  its('extensions') { should include 'aks-preview' }
end

# describe azaccount do
#   its('name') { should eq 'MS-Doma'}
# end
# describe azaccounts do
#   its('count') { should eq 3}
# end

# describe azresource('group','servicebus') do
#   its('name') { should eq "x" }
# end

describe azresources('vm') do
  its('exists') { should eq true }
  its('count') { should eq 4 }
end

describe azresource('vm', 'c7b68245-2681-4408-5449-30e228e3660f', 'withcredhub-bosh') do
  its('exists') { should eq true }
  its(%w[tags job]) { should eq 'bosh' }
  its('location') { should eq 'westus2' }
end

# describe azresource('vm', 'c7sb68245-2681-4408-5449-30e228e3660f', 'withcredhub-bosh') do
#   its('exists') { should eq false }
# end

describe azresource('vm', 'non', 'rg') do
  its('exists') { should eq false }
  its('location') { should eq nil }
  its(%w[tags job]) { should eq nil }
end
