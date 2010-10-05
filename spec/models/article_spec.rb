# encoding: utf-8
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

    context "without category" do
      subject { Factory.build(:article, :category => nil) }
      it_should_behave_like "an invalid model"
    end
  end

  describe "#icon" do
    subject { Factory(:article) }

    it "should return diablo icon for diablo-like categories" do
      subject.category.title = "Diablo 9"
      subject.icon.should == "diablo"
    end

    it "should return starcraft icon for starcraft-like categories" do
      subject.category.title = "Starcraft 98"
      subject.icon.should == "starcraft"
    end

    it "should return blizzard for unknown category" do
      subject.icon.should == "blizzard"
    end
  end

  describe "#extract" do
    it "should return first two sentences" do
      subject.body_raw = "Hello. World. Motherfuckers"
      subject.extract.should == "Hello. World."
    end
    
    it "should cut to 100 symbols" do
      subject.body_raw = "12345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
      subject.extract.should == "1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
      # cyrillics
      subject.body_raw = "аааааааааааааааааааааааааааааааааааааааааааааааааааааааааааааааааааааааааааааааааааааааааааааааааааааааааааааа"
      subject.extract.should == "аааааааааааааааааааааааааааааааааааааааааааааааааааааааааааааааааааааааааааааааааааааааааааааааааааа"
    end 
  end

  it_should_behave_like "Traits::Model::Sluggable"
end
