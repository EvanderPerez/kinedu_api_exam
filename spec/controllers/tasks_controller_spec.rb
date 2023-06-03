require 'rails_helper'

RSpec.describe TasksController, type: :request do
  describe 'GET /tasks' do
    before do
      create_list(:task, 2)
    end

    it 'should get all tasks' do
      get '/tasks'
      expect(response.parsed_body['results'].count).to eq 2
    end
  end
end
