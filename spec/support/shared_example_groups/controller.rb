shared_examples_for "good response" do
  it "should return good response" do
    response.code.should == "200"
  end
end

shared_examples_for "redirect" do
  it "should return redirect" do
    response.code.should == "302"
  end
end

shared_examples_for "redirect or good response" do
  it { ["302", "200"].should include(response.code) }
end

shared_examples_for "bad response" do
  it "should return bad response" do
    response.code.should == "400"
  end
end
