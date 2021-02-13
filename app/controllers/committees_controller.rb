#BE
class CommitteesController < ApplicationController
  def index
    # Show all committees
  end

  def show
    # Show specific committee
  end

  def new
    # Create committee if >executive
    unless user_signed_in? && current_user.check_executive?
      redirect_to root_path, alert: "You do not have permissions"
    end
  end

  def edit
    # Edit Committee if >executive
    unless user_signed_in? && current_user.check_executive?
      redirect_to root_path, alert: "You do not have permissions"
    end
  end

  def delete
    # Delete Committee if >executive
    unless user_signed_in? && current_user.check_executive?
      redirect_to root_path, alert: "You do not have permissions"
    end
  end
end
