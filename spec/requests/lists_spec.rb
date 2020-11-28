require 'rails_helper'

RSpec.describe "/lists", type: :request do
  let(:valid_attributes) {
    {
      :list_id => "L101", 
      :name => "My Personal List"
    }
  }

  let(:invalid_attributes) {
    {
      :list_id => 22, 
      :name => ""
    }
  }

  describe "GET /index" do
    it "renders a successful response" do
      List.create! valid_attributes
      get lists_url, as: :json
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      list = List.create! valid_attributes
      get list_url(list), as: :json
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new List" do
        expect {
          post lists_url, params: valid_attributes , as: :json
        }.to change(List, :count).by(1)
      end

      it "renders a JSON response with the new list" do
        post lists_url, params: valid_attributes , as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "does not create a new List" do
        expect {
          post lists_url, params: invalid_attributes , as: :json
        }.to change(List, :count).by(0)
      end

      it "renders a JSON response with errors for the new list" do
        post lists_url, params: invalid_attributes , as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq("application/json")
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        { name: "New Template Name"}
      }
      it "updates the requested list" do
        list = List.create! valid_attributes
        patch list_url(list), params: new_attributes , as: :json
        list.reload
        expect(response).to have_http_status(:ok)
        expect(list.name).to eq("New Template Name")
      end

      it "renders a JSON response with the list" do
        list = List.create! valid_attributes
        patch list_url(list), params: new_attributes , as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq("application/json")
      end
    end

    context "with invalid parameters" do
      it "renders a JSON response with errors for the list" do
        list = List.create! valid_attributes
        patch list_url(list), params: invalid_attributes , as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq("application/json")
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested list" do
      list = List.create! valid_attributes
      expect {
        delete list_url(list), as: :json
      }.to change(List, :count).by(-1)
    end
  end

  describe "Delete tasks in a lIst" do
    it "should delete all tasks in a list by passing task_id" do
      list = List.create! valid_attributes
      task = FactoryBot.create(:task, list_id: list.id)
      params = {:id=> list.id, :task_ids => [task.id]}
      post '/lists/remove_tasks', params: params, as: :json
      expect(response).to be_successful
    end
  end
end
