require 'spec_helper'

class TestModelEditableByNewsmakers < BaseModel
  include ::Traits::Model::AccessControl::Editable
  include ::Traits::Model::AccessControl::EditableByNewsmakers
  
  property :id, Serial
end

DataMapper.auto_migrate!

describe ::Traits::Model::AccessControl::EditableByNewsmakers do
  subject { TestModelEditableByNewsmakers.create }
  let(:described_class) { subject.class }  

  [:newsmaker].each do |person_group|
    context "for #{person_group ? person_group : "anonymous user"}" do
      let(:person) { person_group ? Factory(person_group) : nil }

      it "should be editable" do
        subject.should be_editable_by(person)
      end
      
      it "should be included in editable scope" do
        described_class.editable_by(person).should include(subject)
      end
    end
  end
  
  [:person, :admin, :moderator, nil].each do |person_group|
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
  
end
