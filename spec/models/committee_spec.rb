require 'rails_helper'

RSpec.describe Committee, :type => :model do
  describe "is valid committee" do
    it "has a name" do
      test_committee = Committee.new(:name => '')
      expect(test_committee).to_not be_valid

      test_committee.name = 'Test Committee Name'
      expect(test_committee).to be_valid
    end
  end
end
