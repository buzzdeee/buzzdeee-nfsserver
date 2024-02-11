require 'spec_helper'
describe 'nfsserver' do
  context 'with defaults for all parameters' do
    it { is_expected.to contain_class('nfsserver') }
  end
end
