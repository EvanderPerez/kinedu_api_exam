require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :request do
  include_context 'log-in'

  let!(:user) { create(:user) }

  describe 'GET /users' do
    before do
      create_list(:user, 2)
    end

    it 'should get all users' do
      get '/api/v1/users'
      # The result count is higher because I have already created an user for login
      #   and the common user for the Show, Update and Destroy methods
      expect(response.parsed_body['results'].count).to eq 4
    end
  end

  describe 'GET /users/:id' do
    it 'should get one single user' do
      get "/api/v1/users/#{user.id}"
      expect(response.parsed_body['result']['email']).to eq user.email
    end
  end

  describe 'POST /users/' do
    let(:user_params) { attributes_for(:user) }
    let(:params) do
      {
        user: user_params
      }
    end

    it 'should create one single user' do
      post "/api/v1/users", params: params, headers: @auth_headers
      expect(response.parsed_body['result']['email']).to eq user_params[:email]
    end
  end

  describe 'PUT /users/{id}' do
    let(:user_params) { attributes_for(:user) }
    let(:params) do
      {
        user: user_params
      }
    end

    it 'should create one single user' do
      put "/api/v1/users/#{user.id}", params: params, headers: @auth_headers
      expect(response.parsed_body['result']['id']).to eq user.id
      expect(response.parsed_body['result']['email']).to eq user_params[:email]
    end
  end

  describe 'GET /users/:id' do
    it 'should get one single user' do
      delete "/api/v1/users/#{user.id}", headers: @auth_headers
      expect(response.parsed_body['success']).to eq true
    end
  end
end
