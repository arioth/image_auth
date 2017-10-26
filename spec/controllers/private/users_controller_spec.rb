require 'rails_helper'

RSpec.describe Private::UsersController, type: :controller do
  describe 'POST #verify_email' do
    let(:username) { ENV['PRIVATE_USERNAME'] }
    let(:password) { ENV['PRIVATE_PASSWORD'] }
    let(:email) { 'jon.now@stark.com' }
    let(:another_email) { 'john.doe@example.com' }

    before do
      request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(
        username, password
      )
      allow(AuthMailer).to receive_message_chain(:success_auth, :deliver_later)
      allow(AuthMailer).to receive_message_chain(:failed_auth, :deliver_later)
      create(:user, email: email, image: 'This is an image')
    end

    it 'returns http status ok if user and images match' do
      post :verify_email, params: { email: email, image: 'This is an image' }
      expect(response).to have_http_status(:success)
    end

    it 'sends an success_auth email if user and images match' do
      expect(AuthMailer).to receive(:success_auth).once
      post :verify_email, params: { email: email, image: 'This is an image' }
    end

    it 'returns http status unauthorized if user does not exists' do
      post :verify_email, params: { email: another_email, image: 'This is an image' }
      expect(response).to have_http_status(:unauthorized)
    end

    it 'returns http status unauthorized if images do not match' do
      post :verify_email, params: { email: email, image: 'This is another image' }
      expect(response).to have_http_status(:unauthorized)
    end

    it 'sends an failed_auth email if user and images match' do
      expect(AuthMailer).to receive(:failed_auth).once
      post :verify_email, params: { email: email, image: 'This is another image' }
    end
  end
end