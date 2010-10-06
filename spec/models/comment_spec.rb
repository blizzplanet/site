require 'spec_helper'

describe Comment do
  subject { Factory.build(:comment) }

  context "validations:" do
    context "with valid attributes" do
      subject { Factory.build(:comment) }
      it_should_behave_like "a valid model"
    end

    context "without body_raw" do
      subject { Factory.build(:comment, :body_raw => "") } 
      it_should_behave_like "an invalid model"
    end
  end
end
