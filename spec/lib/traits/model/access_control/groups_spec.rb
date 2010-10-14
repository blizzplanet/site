require 'spec_helper'

class TestModelAccessControlGroups
  include ::Traits::Model::AccessControl::Groups
end

describe ::Traits::Model::AccessControl::Groups do
  subject { TestModelAccessControlGroups.new }
  describe "#groups" do
    it "should return empty array" do
      subject.groups.should == []
    end    
  end
end
