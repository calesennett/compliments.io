require 'rails_helper'

describe DigitsController do
  describe 'POST #create' do
    context 'when valid authentication credentials' do
      it 'creates a user' do
        stub_request(:get, "https://api.digits.com/1.1/sdk/account.json").with(
          headers: {
            'Accept'=>'*/*',
            'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
            'Authorization'=>'auth',
            'User-Agent'=>'Ruby'
          }).to_return(
            status: 200,
            body: '{"id_str":"2314"}',
            headers: {}
          )

        expect {
          post :create, params: {"apiUrl" => 'https://api.digits.com/1.1/sdk/account.json', "credentials" => 'auth'}
        }.to change { User.count }
      end
    end

    context 'when invalid authentication credentials' do
      it 'does not create a user' do
        stub_request(:get, "https://api.digits.com/1.1/sdk/account.json").with(
          headers: {
            'Accept'=>'*/*',
            'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
            'Authorization'=>'auth',
            'User-Agent'=>'Ruby'
          }).to_return(
            status: 200,
            body: '{"id_str":""}',
            headers: {}
          )

        expect {
          post :create, params: {"apiUrl" => 'https://api.digits.com/1.1/sdk/account.json', "credentials" => 'auth'}
        }.to_not change { User.count }
      end
    end
  end
end
