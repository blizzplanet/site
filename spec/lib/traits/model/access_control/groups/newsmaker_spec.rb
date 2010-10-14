require 'spec_helper'

class TestModelGroupsNewsmaker < BaseModel
  include ::Traits::Model::AccessControl::Groups
  include ::Traits::Model::AccessControl::Groups::Newsmaker

  property :id, Serial
end

DataMapper.auto_migrate!

describe ::Traits::Model::AccessControl::Groups::Newsmaker do
  subject { TestModelGroupsNewsmaker.new }
  let(:described_class) { subject.class }
  
  it "should have :newsmaker property with false default" do
    subject.newsmaker.should be_false
  end
  
  describe "#newsmaker?" do
    it "should return true when person is a newsmaker" do
      subject.newsmaker = true
      subject.should be_newsmaker
    end
    
    it "should return false when person is not a newsmaker" do
      subject.newsmaker = false
      subject.should_not be_newsmaker
    end
  end
  
  
  describe "#groups" do
    context "for newsmaker" do
      before(:each) { subject.newsmaker = true }
      it "should include :newsmaker" do
        subject.groups.should include(:newsmaker)
      end
    end
    
    context "for non-newsmaker" do
      it "should not include :newsmaker" do
        subject.groups.should_not include(:newsmaker)
      end
    end
  end
  
end
