require 'rails_helper'

RSpec.describe Api::V1::TasksController, type: :request do
  include_context 'log-in'

  let!(:user) { create(:user) }
  let!(:task) { create(:task, created_by: user) }

  describe 'GET /tasks' do
    before do
      create_list(:task, 2)
    end

    it 'should get all tasks' do
      get '/api/v1/tasks', headers: @auth_headers
      expect(response.parsed_body['results'].count).to eq 3
    end
  end

  describe 'GET /tasks/:id' do
    it 'should get one single task' do
      get "/api/v1/tasks/#{task.id}", headers: @auth_headers
      expect(response.parsed_body['result']['name']).to eq task.name
    end
  end

  describe 'POST /tasks/' do
    let(:task_params) { attributes_for(:task, created_by: user) }
    let(:params) do
      {
        task: task_params
      }
    end

    it 'should create one single task' do
      post "/api/v1/tasks", params: params, headers: @auth_headers
      expect(response.parsed_body['result']['name']).to eq task_params[:name]
    end
  end

  describe 'PUT /tasks/{id}' do
    let(:task_params) { attributes_for(:task, status: :in_progress) }
    let(:params) do
      {
        task: task_params
      }
    end

    it 'should create one single task' do
      put "/api/v1/tasks/#{task.id}", params: params, headers: @auth_headers
      expect(response.parsed_body['result']['id']).to eq task.id
      expect(response.parsed_body['result']['status']).to eq 'in_progress'
    end
  end

  describe 'GET /tasks/:id' do
    it 'should get one single task' do
      delete "/api/v1/tasks/#{task.id}", headers: @auth_headers
      expect(response.parsed_body['success']).to eq true
    end
  end
end
