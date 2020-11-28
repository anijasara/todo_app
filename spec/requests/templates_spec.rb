require 'rails_helper'

RSpec.describe "/templates", type: :request do
  let(:valid_attributes) {
    {
      :template_id => "T101", 
      :name => "My Template"
    }
  }

  let(:invalid_attributes) {
    {
      :template_id => 22, 
      :name => ""
    }
  }


  describe "GET /index" do
    it "renders a successful response" do
      Template.create! valid_attributes
      get templates_url, as: :json
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      template = Template.create! valid_attributes
      get template_url(template), as: :json
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Template" do
        expect {
          post '/templates', params: valid_attributes , as: :json
        }.to change(Template, :count).by(1)
      end

      it "renders a JSON response with the new template" do
        post '/templates', params: valid_attributes , as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Template" do
        expect {
          post '/templates', params: invalid_attributes , as: :json
        }.to change(Template, :count).by(0)
      end

      it "renders a JSON response with errors for the new template" do
        post '/templates', params: invalid_attributes , as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq("application/json")
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        {name: "New Name"}
      }

      it "updates the requested template's name" do
        template = Template.create! valid_attributes
        patch template_url(template), params: new_attributes , as: :json
        template.reload
        expect(response).to have_http_status(:ok)
      end

      it "renders a JSON response with the template" do
        template = Template.create! valid_attributes
        patch template_url(template), params: new_attributes , as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq("application/json")
      end
    end

    context "with invalid parameters" do
      it "renders a JSON response with errors for the template" do
        template = Template.create! valid_attributes
        patch template_url(template), params: invalid_attributes , as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq("application/json")
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested template" do
      template = Template.create! valid_attributes
      expect {
        delete template_url(template), as: :json
      }.to change(Template, :count).by(-1)
    end
  end
end
