require 'swagger_helper'

RSpec.describe "Users", type: :request do
  include_context 'create user for log-in'

  describe 'Index method for users' do
    path '/api/v1/users' do
      get('#Index') do
        tags 'User'
        consumes 'application/json'
        produces 'application/json'

        before do
          create_list(:user, 3)
        end
        response(200, 'successful') do
          run_test! do |response|
            expect(response.parsed_body['results'].count).to eq(4)
          end
        end
      end
    end
  end

  describe 'Show method for users' do
    path '/api/v1/users/{id}' do
      get('#Show') do
        tags 'User'
        consumes 'application/json'
        produces 'application/json'
        parameter name: :id, in: :path, type: :integer, required: true

        let(:user) { create(:user) }
        let(:id) { user.id }

        response(200, 'successful') do
          run_test! do |response|
            expect(response.parsed_body['result']['email']).to eq(user.email)
          end
        end
      end
    end
  end

  describe 'Create method for users' do
    path '/api/v1/users/' do
      post('#Create') do
        tags 'User'
        consumes 'application/json'
        produces 'application/json'
        parameter name: :user, in: :body, schema: {
          type: :object,
          properties: {
            user: {
              type: :object,
              properties: {
                first_name: { type: :string, example: Faker::Lorem.word },
                last_name: { type: :string, example: Faker::Lorem.word },
                email: { type: :string, example: Faker::Internet.email },
                password: { type: :string, example: Faker::Internet.password }
              }
            }
          }
        }

        response(200, 'successful') do
          let(:user_params) { build(:user).as_json }

          let(:user) do
            {
              user: user_params
            }
          end

          run_test! do |response|
            expect(response.parsed_body['result']['email']).to eq(user_params['email'])
          end
        end
      end
    end
  end

  describe 'Update method for users' do
    path '/api/v1/users/{id}' do
      put('#Update') do
        tags 'User'
        consumes 'application/json'
        produces 'application/json'
        parameter name: :id, in: :path, type: :integer, required: true
        parameter name: :user, in: :body, schema: {
          type: :object,
          properties: {
            user: {
              type: :object,
              properties: {
                first_name: { type: :string, example: Faker::Lorem.word },
                last_name: { type: :string, example: Faker::Lorem.word },
                email: { type: :string, example: Faker::Internet.email },
                password: { type: :string, example: Faker::Internet.password }
              }
            }
          }
        }

        include_context 'headers for swagger'

        response(200, 'successful') do
          let(:user_model) { create(:user) }
          let(:user_params) { build(:user).as_json }
          let(:id) { user_model.id }

          let(:user) do
            {
              user: user_params
            }
          end

          run_test! do |response|
            expect(response.parsed_body['result']['id']).to eq(id)
            expect(response.parsed_body['result']['email']).to eq(user_params['email'])
          end
        end
      end
    end
  end

  describe 'Destroy method for users' do
    path '/api/v1/users/{id}' do
      delete('#Destroy') do
        tags 'User'
        consumes 'application/json'
        produces 'application/json'
        parameter name: :id, in: :path, type: :integer, required: true

        include_context 'headers for swagger'

        response(200, 'successful') do
          let(:user_model) { create(:user) }
          let(:id) { user_model.id }

          run_test! do |response|
            expect(response.parsed_body['success']).to eq(true)
          end
        end
      end
    end
  end
end
