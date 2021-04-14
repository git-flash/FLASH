# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'AttendanceLogs', type: :request do
  describe 'GET /index' do
    it 'returns http success' do
      get '/attendance_logs/index'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /show' do
    it 'returns http success' do
      get '/attendance_logs/show'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /new' do
    it 'returns http success' do
      get '/attendance_logs/new'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /edit' do
    it 'returns http success' do
      get '/attendance_logs/edit'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /delete' do
    it 'returns http success' do
      get '/attendance_logs/delete'
      expect(response).to have_http_status(:success)
    end
  end
end
