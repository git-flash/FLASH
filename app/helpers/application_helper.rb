# frozen_string_literal: true

# Application helper
module ApplicationHelper
  def error_messages_for(object)
    render partial: 'application/error_messages', locals: { object: object }
  end
end
