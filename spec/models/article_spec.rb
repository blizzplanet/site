require 'spec_helper'

describe Article do
  subject { Factory.build(:article) } 
  context "validations:" do
    context "with valid attributes" do
      subject { Factory.build(:article) }
      it_should_behave_like "a valid model"
    end

    context "without title" do
      subject { Factory.build(:article, :title => nil) }
      it_should_behave_like "an invalid model"
    end

    context "without body_raw" do
      subject { Factory.build(:article, :body_raw => nil) }
      it_should_behave_like "an invalid model"
    end
  end

  it_should_behave_like "Traits::Model::Sluggable"
end
