require 'spec_helper'
describe 'nfsserver' do

  context 'with defaults for all parameters' do
    it { should contain_class('nfsserver') }
  end
end
