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
          create_list(:task, 3)
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
    path '/tasks/{id}' do
      get('#Show') do
        tags 'Task'
        consumes 'application/json'
        produces 'application/json'
        parameter name: :id, in: :path, type: :integer, required: true

        let(:task) { create(:task) }
        let(:id) { task.id }

        response(200, 'successful') do
          run_test! do |response|
            expect(response.parsed_body['name']).to eq(task.name)
          end
        end
      end
    end
  end

  describe 'Create method for tasks' do
    path '/tasks/' do
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

        response(200, 'successful') do
          let(:task_params) { build(:task).as_json }

          let(:task) do
            {
              task: task_params
            }
          end

          run_test! do |response|
            expect(response.parsed_body['name']).to eq(task_params['name'])
          end
        end
      end
    end
  end

  describe 'Update method for tasks' do
    path '/tasks/{id}' do
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
                stats: { type: :string, example: 'done'}
              }
            }
          }
        }

        response(200, 'successful') do
          let(:task_model) { create(:task) }
          let(:task_params) { build(:task, status: :in_progress).as_json }
          let(:id) { task_model.id }

          let(:task) do
            {
              task: task_params
            }
          end

          run_test! do |response|
            expect(response.parsed_body['id']).to eq(id)
            expect(response.parsed_body['name']).to eq(task_params['name'])
            expect(response.parsed_body['status']).to eq('in_progress')
          end
        end
      end
    end
  end

  describe 'Destroy method for tasks' do
    path '/tasks/{id}' do
      delete('#Destroy') do
        tags 'Task'
        consumes 'application/json'
        produces 'application/json'
        parameter name: :id, in: :path, type: :integer, required: true

        response(200, 'successful') do
          let(:task_model) { create(:task) }
          let(:id) { task_model.id }

          run_test! do |response|
            expect(response.parsed_body['success']).to eq(true)
          end
        end
      end
    end
  end
end
