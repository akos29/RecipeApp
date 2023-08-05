require 'rails_helper'

RSpec.describe 'Foods', type: :request do
  before(:example) do
    @user = User.first
    sign_in @user
  end

  describe 'GET /index when user is signed in' do
    it 'returns http success if signed in' do
      sign_in @user
      get '/foods'
      expect(response).to have_http_status(:success)
      expect(response.status).to eq(200)
    end

    it 'renders the correct template if signed in' do
      get foods_path
      expect(response).to render_template('index')
    end
  end

  describe 'GET /index when user is signed out' do
    it 'should redirect to sign in page if not signed in' do
      sign_out @user
      get '/foods'
      expect(response).to redirect_to new_user_session_path
      expect(response.status).to eq(302)
    end
  end
end
