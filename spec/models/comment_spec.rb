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
    
    context "without article" do
      subject { Factory.build(:comment, :article => nil) }
      it_should_behave_like "an invalid model"
    end
  end
  
  context "callbacks:" do
    let!(:article) { Factory(:article) }
    subject { Factory.build(:comment, :article => article) }

    context "after create" do
      it "should increment article's version" do
        lambda {
          subject.save
          article.reload
        }.should change(article, :version)
      end
    end

    context "after update" do
      subject { Factory.create(:comment, :article => article) }
      it "should increment article's version" do
        subject
        article.reload
        lambda {
          subject.body_raw = "Something else"
          subject.save
          article.reload
        }.should change(article, :version)
      end
    end
  end
end
