require 'rails_helper'

RSpec.describe Public::UsersController, type: :controller do
  describe 'POST #login' do
    before do
      @private_request = double('private_request')
      allow(RestClient::Request).to receive(:new).and_return(@private_request)
    end

    it 'returns http status ok if the private request is successful' do
      allow(@private_request).to receive(:execute)
      post :login, params: { email: 'jon.now@stark.com', image: 'This is an image' }
      expect(response).to have_http_status(:success)
    end

    it 'returns http status ok if the private request failed' do
      allow(@private_request).to receive(:execute).and_raise(RestClient::ExceptionWithResponse)
      post :login, params: { email: 'jon.now@stark.com', image: 'This is an image' }
      expect(response).to have_http_status(:unauthorized)
    end
  end
end