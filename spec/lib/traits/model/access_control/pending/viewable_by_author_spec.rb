require 'spec_helper'

class TestModelViewableByAuthor < BaseModel
  include ::Traits::Model::AccessControl::Viewable 
  include ::Traits::Model::AccessControl::Approvable
  include ::Traits::Model::AccessControl::Pending::ViewableByAuthor
  
  property :id, Serial
  belongs_to :author, "Person"
end

DataMapper.auto_migrate!

describe ::Traits::Model::AccessControl::Pending::ViewableByAuthor do
  subject { TestModelViewableByAuthor.create(:author => author) }
  let(:described_class) { subject.class }  
  let(:author) { Factory(:person) }
  context "when it is pending" do
    subject { TestModelViewableByAuthor.create(:approved => false, :author => author) }  
    context "for author" do
      let(:person) { author }

      it "should be viewable" do
        subject.should be_viewable_by(person)
      end
      
      it "should be included in viewable scope" do
        described_class.viewable_by(person).should include(subject)
      end
    end
    
    [:newsmaker, :person, :admin, :moderator, nil].each do |person_group|
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
    subject { TestModelViewableByAuthor.create(:approved => true, :author => author) }
    
    context "for author" do
      let(:person) { subject.author }

      it "should not be viewable" do
        subject.should_not be_viewable_by(person)
      end
      
      it "should not be included in viewable scope" do
        described_class.viewable_by(person).should_not include(subject)
      end
    end    
    
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

  context "for nil author" do
    let(:author) { nil }
    let(:person) { nil }
    it "should not be viewable" do
      subject.should_not be_viewable_by(person)
    end
    
    it "should not be included in viewable scope" do
      described_class.viewable_by(person).should_not include(person)
    end
  end
  
end
