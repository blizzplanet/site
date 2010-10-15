require 'spec_helper'

class TestModelViewableByAll < BaseModel
  include ::Traits::Model::AccessControl::Viewable
  include ::Traits::Model::AccessControl::ViewableByAll
  
  property :id, Serial
end

DataMapper.auto_migrate!

describe ::Traits::Model::AccessControl::ViewableByAll do
  subject { TestModelViewableByAll.create }
  let(:described_class) { subject.class }  

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
