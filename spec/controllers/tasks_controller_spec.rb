require 'rails_helper'

RSpec.describe TasksController, type: :request do
  let!(:task) { create(:task) }

  describe 'GET /tasks' do
    before do
      create_list(:task, 2)
    end

    it 'should get all tasks' do
      get '/tasks'
      expect(response.parsed_body['results'].count).to eq 3
    end
  end

  describe 'GET /tasks/:id' do
    it 'should get one single task' do
      get "/tasks/#{task.id}"
      expect(response.parsed_body['name']).to eq task.name
    end
  end
end
