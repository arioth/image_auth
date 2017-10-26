require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let!(:user) { create(:user) }
  let(:file_path) { File.join(Rails.root, '/spec/fixtures/images/profile-image.png') }

  describe 'GET #index' do
    it 'assigns all the users as @users' do
      get :index
      expect(assigns(:users)).to eq(User.all)
    end

    it 'responds with http status ok' do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #show' do
    it 'assigns the user as @user' do
      get :show, params: { id: user.id }
      expect(assigns(:user)).to eq(user)
    end

    it 'raises an ActiveRecord::RecordNotFound exception if user does not exist' do
      expect{ get :show, params: { id: 0 } }.to raise_exception(ActiveRecord::RecordNotFound)
    end

    it 'responds with http status ok if the user exists' do
      get :show, params: { id: user.id }
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #new' do
    it 'assigns a new user as @user' do
      get :new
      assigned_user = assigns(:user)
      expect(assigned_user.new_record?).to be true
    end
  end

  describe 'POST #create' do
    it 'creates a new user' do
      expect(User.count).to eq(1)
      post :create, params: {
        user: {
          image_file: fixture_file_upload(file_path,'image/png'),
          email: 'jon@doe.com'
        }
      }
      expect(User.count).to eq(2)
    end

    it 'does not creates the user if email is missing' do
      expect(User.count).to eq(1)
      post :create, params: {
        user: {
          image_file: fixture_file_upload(file_path,'image/png')
        }
      }
      expect(User.count).to eq(1)
    end

    it 'does not creates the user if image_file is missing' do
      expect(User.count).to eq(1)
      post :create, params: {
        user: {
          email: 'jon@doe.com'
        }
      }
      expect(User.count).to eq(1)
    end
  end

  describe 'GET #edit' do
    it 'assigns the user as @user' do
      get :edit, params: { id: user.id }
      expect(assigns(:user)).to eq(user)
    end
  end

  describe 'PUT #update' do
    it 'does not create a new user' do
      expect(User.count).to eq(1)
      post :create, params: {
        user: {
          image_file: fixture_file_upload(file_path,'image/png')
        }
      }
      expect(User.count).to eq(1)
    end

    it 'does not edit the email' do
      new_email = 'jon@doe.com'
      post :create, params: {
        user: {
          image_file: fixture_file_upload(file_path,'image/png'),
          email: new_email
        }
      }
      expect(user.reload.email).to_not eq(new_email)
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes a user' do
      expect(User.count).to eq(1)
      delete :destroy, params: { id: user.id }
      expect(User.count).to eq(0)
    end
  end
end
