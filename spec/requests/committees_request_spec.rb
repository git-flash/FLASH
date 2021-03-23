require 'rails_helper'

RSpec.describe "Committees", :type => :request do

  describe "GET /index" do
    it "returns http success" do
      get "/committees/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/committees/show"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
    it "returns http success" do
      get "/committees/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      get "/committees/edit"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /delete" do
    it "returns http success" do
      get "/committees/delete"
      expect(response).to have_http_status(:success)
    end
  end

end
