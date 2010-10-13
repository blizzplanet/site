require 'spec_helper'

class TestModel < BaseModel
  include ::Traits::Model::AccessControl::Approvable
  
  property :id, Serial
end

DataMapper.auto_migrate!

describe ::Traits::Model::AccessControl::Approvable do
  subject { TestModel.create }
  let(:described_class) { subject.class }

  it "should define :approved property with falsy default" do
    subject.approved.should be_false
  end

  describe "#approvable_by?" do
    it "should return false by default" do
      subject.approvable_by?(nil).should be_false
    end
  end
  
  describe "#approved?" do
    it "should return false when :approved is false" do
      subject.approved = false
      subject.should_not be_approved
    end
    
    it "should return true when :approved is true" do
      subject.approved = true
      subject.should be_approved
    end    
  end

  describe "#pending?" do
    it "should return false when :approved is true" do
      subject.approved = true
      subject.should_not be_pending
    end
    
    it "should return true when :approved is false" do
      subject.approved = false
      subject.should be_pending
    end    
  end
  
  describe "#approve!" do
    it "should set approved status to true and persist model" do
      subject.approve!
      subject.reload.should be_approved
    end
  end
  
  describe "#unapprove!" do
    it "should set approved status to false and persist model" do
      subject.unapprove!
      subject.reload.should_not be_approved
    end
  end
  
  describe ".approvable_by" do
    before(:each) { 3.times { TestModel.create } }
    it "should return an empty scope" do
      described_class.approvable_by(nil).count.should == 0
    end
  end
end
