require 'spec_helper'

class TestModelCreatableByPeople < BaseModel
  include ::Traits::Model::AccessControl::Creatable
  include ::Traits::Model::AccessControl::CreatableByPeople
  
  property :id, Serial
end

DataMapper.auto_migrate!

describe ::Traits::Model::AccessControl::CreatableByPeople do
  subject { TestModelCreatableByPeople.create }
  let(:described_class) { subject.class }

  describe ".creatable_by?" do
    [:person, :newsmaker, :moderator, :admin].each do |person_group|
      context "for #{person_group}" do
        let(:person) { Factory(person_group) }
        it "should return true for #{person_group}" do
          described_class.creatable_by?(person).should be_true
        end        
      end
    end
    
    [nil].each do |person_group|
      context "for #{person_group || 'anonymous'}" do
        let(:person) { person_group ? Factory(person_group) : nil }
        it "should return false for #{person_group || 'anonymous'}" do
          described_class.creatable_by?(person).should be_false
        end
      end
    end
  end
end
