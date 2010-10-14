require 'spec_helper'

class TestModelEditableByAuthor < BaseModel
  include ::Traits::Model::AccessControl::Editable 
  include ::Traits::Model::AccessControl::EditableByAuthor
  
  property :id, Serial
  belongs_to :author, "Person", :required => false
end

DataMapper.auto_migrate!

describe ::Traits::Model::AccessControl::EditableByAuthor do
  subject { TestModelEditableByAuthor.create(:author => author) }
  let(:described_class) { subject.class }  
  let(:author) { Factory(:person) }
  context "for author" do
    let(:person) { author }

    it "should be editable" do
      subject.should be_editable_by(person)
    end
    
    it "should be included in editable scope" do
      described_class.editable_by(person).should include(subject)
    end
  end
  
  [:newsmaker, :person, :admin, :moderator, nil].each do |person_group|
    context "for #{person_group ? person_group : "anonymous user"}" do
      let(:person) { person_group ? Factory(person_group) : nil }

      it "should not be editable" do
        subject.should_not be_editable_by(person)
      end
      
      it "should not be included in editable scope" do
        described_class.editable_by(person).should_not include(subject)
      end
    end
  end

  context "for nil author" do
    let(:author) { nil }
    let(:person) { subject.author } # nil
    it "should not be editable" do
      subject.should_not be_editable_by(person)
    end
    
    it "should not be included in editable scope" do
      described_class.editable_by(person).should_not include(subject)
    end
  end
  
end
