require 'rails_helper'

RSpec.describe Committee, :type => :model do
  it 'has a name' do
    testCommittee = Committee.new(name: '')
    expect(testCommittee).to_not be_valid

    testCommittee.name = 'Test Committee Name'
    expect(testCommittee).to be_valid
  end
end
