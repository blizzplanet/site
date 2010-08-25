require 'spec_helper'

describe Category do
  context "validations:" do
    context "with valid attributes" do
      subject { Factory.build(:category) } 
      it_should_behave_like "a valid model" 
    end

    context "without title" do
      subject { Factory.build(:category, :title => nil) } 
      it_should_behave_like "an invalid model"
    end
  end
end
