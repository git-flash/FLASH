# frozen_string_literal: true

# Help controller
class HelpController < ApplicationController
  before_action :confirm_logged_in, only: [:user_manual]
  def contact; end

  def user_manual; end
end
