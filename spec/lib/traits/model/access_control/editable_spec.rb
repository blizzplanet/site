require 'spec_helper'

class TestModel < BaseModel
  include ::Traits::Model::AccessControl::Editable
  
  property :id, Serial
end

DataMapper.auto_migrate!

describe ::Traits::Model::AccessControl::Editable do
  subject { TestModel.create }
  let(:described_class) { subject.class }
  describe "#editable_by?" do
    it "should return false by default" do
      subject.editable_by?(nil).should be_false
    end
  end
  
  describe ".editable_by" do
    before(:each) { 3.times { TestModel.create } }
    it "should return an empty scope" do
      described_class.editable_by(nil).count.should == 0
    end
  end
end
