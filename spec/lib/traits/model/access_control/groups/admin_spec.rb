require 'spec_helper'

class TestModelGroupsAdmin < BaseModel
  include ::Traits::Model::AccessControl::Groups  
  include ::Traits::Model::AccessControl::Groups::Admin

  property :id, Serial
end

DataMapper.auto_migrate!

describe ::Traits::Model::AccessControl::Groups::Admin do
  subject { TestModelGroupsAdmin.new }
  let(:described_class) { subject.class }
  
  it "should have :admin property with false default" do
    subject.admin.should be_false
  end
  
  describe "#admin?" do
    it "should return true when person is an admin" do
      subject.admin = true
      subject.should be_admin
    end
    
    it "should return false when person is not an admin" do
      subject.admin = false
      subject.should_not be_admin
    end
  end
  
  describe "#groups" do
    context "for admin" do
      before(:each) { subject.admin = true }
      it "should include :admin" do
        subject.groups.should include(:admin)
      end
    end
    
    context "for non-admin" do
      it "should not include :admin" do
        subject.groups.should_not include(:admin)
      end
    end
  end
  
end
