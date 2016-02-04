require 'spec_helper'
require 'mfa_watchdog'

describe Heroku do

  it 'filters exceptions' do
    exceptions = 'test@exception.net'
    mock_api = double()
    mock_list = double()
    allow(mock_api).to receive(:organization_member).and_return(mock_list)
    allow(mock_list).to receive(:list).and_return([{'email' => 'test@exception.net', 'two_factor_authentication' => false}])
    h = Heroku.new('testorg', exceptions, mock_api)
    expect(h.check_compliance).to eq []
  end

end
