require 'spec_helper'

class TestModel < BaseModel
  include ::Traits::Model::AccessControl::Groups::Moderator

  property :id, Serial
end

DataMapper.auto_migrate!

describe ::Traits::Model::AccessControl::Groups::Moderator do
  subject { TestModel.new }
  let(:described_class) { subject.class }
  
  it "should have :moderator property with false default" do
    subject.moderator.should be_false
  end
  
  describe "#moderator?" do
    it "should return true when person is a moderator" do
      subject.moderator = true
      subject.should be_moderator
    end
    
    it "should return false when person is not a moderator" do
      subject.moderator = false
      subject.should_not be_moderator
    end
  end
end
