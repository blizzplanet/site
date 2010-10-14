require 'spec_helper'

class TestModelDeletableByModerators < BaseModel
  include ::Traits::Model::AccessControl::Deletable
  include ::Traits::Model::AccessControl::DeletableByModerators
  
  property :id, Serial
end

DataMapper.auto_migrate!

describe ::Traits::Model::AccessControl::DeletableByModerators do
  subject { TestModelDeletableByModerators.create }
  let(:described_class) { subject.class }  

  [:moderator].each do |person_group|
    context "for #{person_group ? person_group : "anonymous user"}" do
      let(:person) { person_group ? Factory(person_group) : nil }

      it "should be deletable" do
        subject.should be_deletable_by(person)
      end
      
      it "should be included in deletable scope" do
        described_class.deletable_by(person).should include(subject)
      end
    end
  end
  
  [:person, :admin, :newsmaker, nil].each do |person_group|
    context "for #{person_group ? person_group : "anonymous user"}" do
      let(:person) { person_group ? Factory(person_group) : nil }

      it "should not be deletable" do
        subject.should_not be_deletable_by(person)
      end
      
      it "should not be included in deletable scope" do
        described_class.deletable_by(person).should_not include(subject)
      end
    end
  end
  
end
