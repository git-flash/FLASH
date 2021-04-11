require 'rails_helper'

RSpec.describe Committee, :type => :model do
  describe "is valid committee" do
    test_committee = described_class.new(:name => '')
    expect(test_committee).not_to be_valid

    test_committee.name = 'Test Committee Name'
    expect(test_committee).to be_valid
  end
end
