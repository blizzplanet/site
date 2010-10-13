require 'spec_helper'

class TestModel < BaseModel
  include ::Traits::Model::AccessControl::Approvable
  include ::Traits::Model::AccessControl::Pending::ApprovableByNewsmakers
  
  property :id, Serial
end

DataMapper.auto_migrate!

describe ::Traits::Model::AccessControl::Pending::ApprovableByNewsmakers do
  subject { TestModel.create }
  let(:described_class) { subject.class }  

  context "when it is pending" do
    subject { TestModel.create(:approved => false) }
    [:newsmaker].each do |person_group|
      context "for #{person_group ? person_group : "anonymous user"}" do
        let(:person) { person_group ? Factory(person_group) : nil }

        it "should be approvable" do
          subject.should be_approvable_by(person)
        end
        
        it "should not be included in approvable scope" do
          described_class.approvable_by(person).should include(subject)
        end
      end
    end
    
    [:person, :admin, :moderator, nil].each do |person_group|
      context "for #{person_group ? person_group : "anonymous user"}" do
        let(:person) { person_group ? Factory(person_group) : nil }

        it "should not be approvable" do
          subject.should_not be_approvable_by(person)
        end
        
        it "should not be included in approvable scope" do
          described_class.approvable_by(person).should_not include(subject)
        end
      end
    end
  end

  context "when it is not pending" do
    subject { TestModel.create(:approved => true) }    
    [:newsmaker].each do |person_group|
      context "for #{person_group ? person_group : "anonymous user"}" do
        let(:person) { person_group ? Factory(person_group) : nil }

        it "should be approvable" do
          subject.should be_approvable_by(person)
        end
        
        it "should not be included in approvable scope" do
          described_class.approvable_by(person).should_not include(subject)
        end
      end
    end
        
    [:person, :admin, :moderator, nil].each do |person_group|
      context "for #{person_group ? person_group : "anonymous user"}" do
        let(:person) { person_group ? Factory(person_group) : nil }

        it "should not be approvable" do
          subject.should_not be_approvable_by(person)
        end
        
        it "should not be included in approvable scope" do
          described_class.approvable_by(person).should_not include(subject)
        end
      end
    end
  end
  
end
