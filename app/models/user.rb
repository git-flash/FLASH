class User < ApplicationRecord
  belongs_to :committee
  has_secure_password
end
