shared_examples_for "a valid model" do
  it "should be valid" do
    subject.should be_valid
  end
end

shared_examples_for "an invalid model" do
  it "should not be valid" do
    subject.should_not be_valid
  end
end