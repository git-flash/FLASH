# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) do
    described_class.new(first_name: 'some_first_name', last_name: 'some_last_name,', email: 'test@test.com',
                        password: 'password', uin: 123_456_789)
  end

  describe 'Validations' do
    it 'is valid with valid attributes' do
      expect(user).to be_valid
    end

    it 'is not valid without a title' do
      user.first_name = nil
      expect(user).not_to be_valid
    end

    it 'is not valid without an author' do
      user.last_name = nil
      expect(user).not_to be_valid
    end
  end
end
