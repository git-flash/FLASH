# frozen_string_literal: true

# ST
class AttendanceUserController < ApplicationController
  before_action :confirm_logged_in

  def index; end

  def show
    @user = User.find(params[:id])
  end
end
