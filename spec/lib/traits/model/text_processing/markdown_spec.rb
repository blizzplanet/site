require "spec_helper"

describe Traits::Model::TextProcessing::Markdown do
  let!(:test_class) do
    Class.new do
      extend  ::ActiveModel::Naming
      include ::ActiveModel::Conversion
      include ::ActiveModel::Validations
      include ::ActiveModel::Validations::Callbacks

      include ::Traits::Model::TextProcessing::Markdown

      attr_accessor :body_raw, :body
      markdown      :body_raw => :body
    end
  end

  subject { test_class.new }

  it "should convert text to markdown before validation" do
    subject.body_raw = "hi **thar**"
    subject.valid?
    subject.body.should include("hi", "<strong>thar</strong>")
  end

  it "should not allow html" do
    subject.body_raw = "<b>ololo</b>"
    subject.valid?
    subject.body.should_not include("<b>")
    subject.body.should include("&lt;b")
  end

  it "should not allow js" do
    subject.body_raw = "[wtf](javascript:document.wtf=omg)"
    subject.valid?
    subject.body.should_not =~ /href=["']javascript:document\.wtf=omg/
  end

  it "should autolink" do
    subject.body_raw = "http://blizzplanet.ru"
    subject.valid?
    subject.body.should =~ /href=["']http:\/\/blizzplanet\.ru/
  end

  it "should not choke on nil" do
    subject.body_raw = nil
    subject.valid?
    subject.body.should be_blank
  end
end