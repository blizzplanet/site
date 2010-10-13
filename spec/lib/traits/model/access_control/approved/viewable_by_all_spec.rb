require 'spec_helper'

class TestModel < BaseModel
  include ::Traits::Model::AccessControl::Viewable
  include ::Traits::Model::AccessControl::Approvable
  include ::Traits::Model::AccessControl::Approved::ViewableByAll
  
  property :id, Serial
end

DataMapper.auto_migrate!

describe ::Traits::Model::AccessControl::Approved::ViewableByAll do
  subject { TestModel.create }
  let(:described_class) { subject.class }  

  context "when it is approved" do
    subject { TestModel.create(:approved => true) }
    [:person, :admin, :moderator, :newsmaker, nil].each do |person_group|
      context "for #{person_group ? person_group : "anonymous user"}" do
        let(:person) { person_group ? Factory(person_group) : nil }

        it "should be viewable" do
          subject.should be_viewable_by(person)
        end
        
        it "should be included in viewable scope" do
          described_class.viewable_by(person).should include(subject)
        end
      end
    end
  end

  context "when it is not approved" do
    subject { TestModel.create(:approved => false) }
    [:person, :admin, :moderator, :newsmaker, nil].each do |person_group|
      context "for #{person_group ? person_group : "anonymous user"}" do
        let(:person) { person_group ? Factory(person_group) : nil }

        it "should not be viewable" do
          subject.should_not be_viewable_by(person)
        end
        
        it "should not be included in viewable scope" do
          described_class.viewable_by(person).should_not include(subject)
        end
      end
    end
  end
  
end
