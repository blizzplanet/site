require 'spec_helper'

describe Category do
  subject { Factory.build(:category) }

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

  describe "#children_articles" do
    let!(:root) { Factory(:category, :parent => nil) }
    subject { root.children.new(Factory.attributes_for(:category).except(:parent)) }
    let!(:article) { Factory(:article, :category => subject)}

    it "should contain own articles" do
      subject.reload.children_articles.should include(article)
    end

    it "should contain children categories' articles" do
      other_category = subject.children.new(Factory.attributes_for(:category).except(:parent))
      other_category.save
      other_article = Factory(:article, :category => other_category)
      subject.reload.children_articles.should include(other_article)
    end

    it "should not contain other categories' articles" do
      other_category = root.children.new(Factory.attributes_for(:category).except(:parent))
      other_article = Factory(:article, :category => other_category)
      subject.reload.children_articles.should_not include(other_article)
    end
  end

  it_should_behave_like "Traits::Model::Sluggable"
end
