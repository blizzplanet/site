require 'spec_helper'

class TestModel < BaseModel
  include ::Traits::Model::AccessControl::Creatable
  
  property :id, Serial
end

DataMapper.auto_migrate!

describe ::Traits::Model::AccessControl::Creatable do
  subject { TestModel.create }
  let(:described_class) { subject.class }

  describe ".creatable_by?" do
    it "should return false" do
      described_class.creatable_by?(nil).should be_false
    end
  end
end
