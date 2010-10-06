# You should pass a non-persisted model to those specs
shared_examples_for "Traits::Model::Sluggable" do
  let(:slug_field) { subject.send(:slug_field) }

  it "should respond to #slug, #slug=, #base_slug, #base_slug=" do
    subject.should respond_to(:slug, :slug=, :base_slug, :base_slug=)
  end

  context "without slug" do
    before(:each) { subject.stub!(:slug).and_return("") }
    it_should_behave_like "an invalid model"
  end

  describe "#generate_slug" do
    before(:each) { subject.send("#{slug_field}=", "Hello, world"); subject.base_slug = nil }

    it "should generate a slug from given slug field omitting punctuation and special symbols" do
      subject.send(:generate_slug).should == "hello-world"
    end

    it "should add a prefix to slug if there is a model with given params already" do
      clone = subject.dup
      clone.save!
      subject.send(:generate_slug).should == "hello-world--1"
    end

    it "should allow prefixes" do
      subject.stub!(:slug_prefix).and_return("oldskool/")
      subject.send(:generate_slug).should == "oldskool-hello-world"
    end

    it "should not be amused by similarly looking sluggables" do
      clone = subject.dup
      clone.send("#{slug_field}=", "hello-world-yo")
      clone.save!
      subject.send(:generate_slug).should == "hello-world"
    end
  end

  it "should generate slug before validations" do
    subject.slug = nil
    subject.stub!(slug_field).and_return("Hello, world, yo")
    subject.should be_valid
    subject.slug.should == "hello-world-yo"
  end

  it "should regenerate slug if slug field has changed" do
    subject.save
    subject.send("#{slug_field}=", "HAI THAR")
    subject.save
    subject.slug.should == "hai-thar"
  end

  it "should not fail with empty slug field" do
    lambda {
      subject.send("#{slug_field}=", "")
      subject.save
    }.should_not raise_error
  end

  it "should convert special symbols to dashes" do
    lambda {
      subject.send("#{slug_field}=", "\\\\")
      subject.save
    }.should_not raise_error
    subject.base_slug.should == "-"
  end

end