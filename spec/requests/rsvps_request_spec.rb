require 'rails_helper'

RSpec.describe "Rsvps", type: :request do

  describe "GET /index" do
    it "returns http success" do
      get "/rsvps/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/rsvps/show"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
    it "returns http success" do
      get "/rsvps/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      get "/rsvps/edit"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /delete" do
    it "returns http success" do
      get "/rsvps/delete"
      expect(response).to have_http_status(:success)
    end
  end

end
