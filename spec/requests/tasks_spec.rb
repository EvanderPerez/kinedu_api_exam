require 'swagger_helper'

RSpec.describe 'tasks', type: :request do

  describe 'Index method for tasks' do
    path '/tasks' do
      get('#Index') do
        tags 'Task'
        consumes 'application/json'
        produces 'application/json'
        parameter name: :status, in: :query, type: :string, required: false
        parameter name: :text, in: :query, type: :string, required: false

        before do
          create_list(:tast, 3)
        end

        response(200, 'successful') do
          run_test! do |response|
            expect(response.parsed_body['results'].count).to eq(3)
          end
        end
      end
    end
  end
end
