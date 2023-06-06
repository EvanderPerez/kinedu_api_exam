require 'swagger_helper'

RSpec.describe 'tasks', type: :request do
  include_context 'create user for log-in'

  let!(:user) { create(:user) }

  describe 'Index method for tasks' do
    path '/api/v1/tasks' do
      get('#Index') do
        tags 'Task'
        consumes 'application/json'
        produces 'application/json'
        parameter name: :status, in: :query, type: :string, required: false
        parameter name: :text, in: :query, type: :string, required: false

        include_context 'headers for swagger'

        before do
          create_list(:task, 3, created_by: user)
        end
        response(200, 'successful') do
          run_test! do |response|
            expect(response.parsed_body['results'].count).to eq(3)
          end
        end
      end
    end
  end

  describe 'Show method for tasks' do
    path '/api/v1/tasks/{id}' do
      get('#Show') do
        tags 'Task'
        consumes 'application/json'
        produces 'application/json'
        parameter name: :id, in: :path, type: :integer, required: true

        include_context 'headers for swagger'

        let(:task) { create(:task, created_by: user) }
        let(:id) { task.id }

        response(200, 'successful') do
          run_test! do |response|
            expect(response.parsed_body['result']['name']).to eq(task.name)
          end
        end
      end
    end
  end

  describe 'Create method for tasks' do
    path '/api/v1/tasks/' do
      post('#Create') do
        tags 'Task'
        consumes 'application/json'
        produces 'application/json'
        parameter name: :task, in: :body, schema: {
          type: :object,
          properties: {
            task: {
              type: :object,
              properties: {
                name: { type: :string, example: Faker::Company.suffix },
                description: { type: :string, example: Faker::Lorem.word }
              }
            }
          }
        }

        include_context 'headers for swagger'

        response(200, 'successful') do
          let(:task_params) { build(:task, created_by: user).as_json }

          let(:task) do
            {
              task: task_params
            }
          end

          run_test! do |response|
            expect(response.parsed_body['result']['name']).to eq(task_params['name'])
          end
        end
      end
    end
  end

  describe 'Update method for tasks' do
    path '/api/v1/tasks/{id}' do
      put('#Update') do
        tags 'Task'
        consumes 'application/json'
        produces 'application/json'
        parameter name: :id, in: :path, type: :integer, required: true
        parameter name: :task, in: :body, schema: {
          type: :object,
          properties: {
            task: {
              type: :object,
              properties: {
                name: { type: :string, example: Faker::Company.suffix },
                description: { type: :string, example: Faker::Lorem.word },
                status: { type: :string, example: 'done'}
              }
            }
          }
        }

        include_context 'headers for swagger'

        response(200, 'successful') do
          let(:task_model) { create(:task, created_by: user) }
          let(:task_params) { build(:task, status: :in_progress).as_json }
          let(:id) { task_model.id }

          let(:task) do
            {
              task: task_params
            }
          end

          run_test! do |response|
            expect(response.parsed_body['result']['id']).to eq(id)
            expect(response.parsed_body['result']['name']).to eq(task_params['name'])
            expect(response.parsed_body['result']['status']).to eq('in_progress')
          end
        end
      end
    end
  end

  describe 'Destroy method for tasks' do
    path '/api/v1/tasks/{id}' do
      delete('#Destroy') do
        tags 'Task'
        consumes 'application/json'
        produces 'application/json'
        parameter name: :id, in: :path, type: :integer, required: true

        include_context 'headers for swagger'

        response(200, 'successful') do
          let(:task_model) { create(:task, created_by: user) }
          let(:id) { task_model.id }

          run_test! do |response|
            expect(response.parsed_body['success']).to eq(true)
          end
        end
      end
    end
  end
end
