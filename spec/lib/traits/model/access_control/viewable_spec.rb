require 'spec_helper'

class TestModel < BaseModel
  include ::Traits::Model::AccessControl::Viewable
  
  property :id, Serial
end

DataMapper.auto_migrate!

describe ::Traits::Model::AccessControl::Viewable do
  subject { TestModel.create }
  let(:described_class) { subject.class }
  describe "#viewable_by?" do
    it "should return false by default" do
      subject.viewable_by?(nil).should be_false
    end
  end
  
  describe ".viewable_by" do
    before(:each) { 3.times { TestModel.create } }
    it "should return an empty scope" do
      described_class.viewable_by(nil).count.should == 0
    end
  end
end
