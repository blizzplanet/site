require 'spec_helper'

class TestModelViewableByNewsmakers < BaseModel
  include ::Traits::Model::AccessControl::Viewable 
  include ::Traits::Model::AccessControl::Approvable
  include ::Traits::Model::AccessControl::Pending::ViewableByNewsmakers
  
  property :id, Serial
end

DataMapper.auto_migrate!

describe ::Traits::Model::AccessControl::Pending::ViewableByNewsmakers do
  subject { TestModelViewableByNewsmakers.create }
  let(:described_class) { subject.class }  

  context "when it is pending" do
    subject { TestModelViewableByNewsmakers.create(:approved => false) }
    [:newsmaker].each do |person_group|
      context "for #{person_group ? person_group : "anonymous user"}" do
        let(:person) { person_group ? Factory(person_group) : nil }

        it "should be viewable" do
          subject.should be_viewable_by(person)
        end
        
        it "should not be included in viewable scope" do
          described_class.viewable_by(person).should include(subject)
        end
      end
    end
    
    [:person, :admin, :moderator, nil].each do |person_group|
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

  context "when it is not pending" do
    subject { TestModelViewableByNewsmakers.create(:approved => true) }
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
