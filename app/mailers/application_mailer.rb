# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'no-reply@flash-point.herokuapp.com'
  layout 'mailer'
end
