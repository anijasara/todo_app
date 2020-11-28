require 'rails_helper'

RSpec.describe "/tasks", type: :request do
  let(:list) {
    FactoryBot.create(:list)
  }

  let(:valid_attributes) {
    {
      :task_id => "T101", 
      :name => "My Task",
      :list_id => list.id,
      :due_at => '2020-12-25',
      :status => 'open'
    }
  }

  let(:invalid_attributes) {
    {
      :task_id => 22, 
      :name => ""
    }
  }


  describe "GET /index" do
    it "renders a successful response" do
      Task.create! valid_attributes
      get tasks_url, as: :json
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      task = Task.create! valid_attributes
      get task_url(task), as: :json
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Task" do
        expect {
          post '/tasks', params: valid_attributes , as: :json
        }.to change(Task, :count).by(1)
      end

      it "renders a JSON response with the new task" do
        post '/tasks', params: valid_attributes , as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Task" do
        expect {
          post '/tasks', params: invalid_attributes , as: :json
        }.to change(Task, :count).by(0)
      end

      it "renders a JSON response with errors for the new task" do
        post '/tasks', params: invalid_attributes , as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq("application/json")
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        {
          :status => 'close',
          :done_at => 'Time.now'
        }
      }

      it "updates the requested task" do
        task = Task.create! valid_attributes
        patch task_url(task), params: new_attributes , as: :json
        task.reload
        expect(response).to have_http_status(:ok)
        expect(task.status).to eq('close')
      end

      it "renders a JSON response with the task" do
        task = Task.create! valid_attributes
        patch task_url(task), params: new_attributes , as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq("application/json")
      end
    end

    context "with invalid parameters" do
      it "renders a JSON response with errors for the task" do
        task = Task.create! valid_attributes
        patch task_url(task), params: invalid_attributes , as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq("application/json")
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested task" do
      task = Task.create! valid_attributes
      expect {
        delete task_url(task), as: :json
      }.to change(Task, :count).by(-1)
    end
  end

  describe "PATCH task status" do
    context "with valid parameters" do
      let(:new_attributes) {
        {
          :status => 'close',
          :done_at => 'Time.now'
        }
      }

      it "updates the status of the requested task" do
        task = Task.create! valid_attributes
        patch "/tasks/#{task.id}/set_task_status", params: new_attributes , as: :json
        task.reload
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe "Get tasks based on status" do
    context "with valid parameters" do
      it "should get all tasks by open status" do
        task = Task.create! valid_attributes
        get '/tasks/get_tasks_by_status', as: :json
        expect(response).to be_successful
      end
    end
  end
end
