require 'spec_helper'
describe 'concrete5' do

  context 'with defaults for all parameters' do
    it { should contain_class('concrete5') }
  end
end
