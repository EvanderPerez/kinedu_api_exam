require 'swagger_helper'

RSpec.describe "SessionsController", type: :request do
  describe 'Log-in method' do
    path '/api/v1/log_in/' do
      post('#log_in') do
        tags 'Session'
        consumes 'application/json'
        produces 'application/json'
        parameter name: :params, in: :body, schema: {
          type: :object,
          properties: {
            email: { type: :string, example: 'evanderperez@hotmail.com' },
            password: { type: :string, example: 'pass123' }
          }
        }

        response(200, 'successful') do
          let(:user) { create(:user) }

          let(:params) do
            {
              email: user.email,
              password: user.password
            }
          end

          run_test! do |response|
            expect(response.parsed_body['user_id']).to eq(user.id)
            expect(response.parsed_body['access_token']).to eq(user.reload.access_token)
          end
        end
      end
    end
  end
end
