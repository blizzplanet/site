require 'spec_helper'

describe ::Traits::Model::Attributes::MassAssignment do
  let(:model) do
    Class.new do
      attr_accessor :values, :flag, :param_one, :param_two
      include Module.new { def initialize(*args); self.values = args[0]; end  }
      include ::Traits::Model::Attributes::MassAssignment
    end
  end
  subject { model.new }

  describe "#initialize" do

    it "should delegate assignment to #attributes=" do
      mod = Module.new { def attributes=(*); super; self.flag = true; end }
      model.send :include, mod
      instance = model.new(:param_one => "hello")
      instance.flag.should be_true
      instance.param_one.should == "hello"
    end


    it "should call super method" do
      model.new(:param_one => "hello").values.should == {:param_one => "hello"}
    end
  end

  describe "#accessible?" do
    it "should return false when setter doesn't exist" do
      subject.accessible?(:wtf).should be_false
    end

    it "should return false when setter exists but isn't accessible" do
      model.attr_accessible(:param_one)
      subject.accessible?(:param_two).should be_false
    end

    it "should return true when setter exists and no accessible attributes are set" do
      subject.accessible?(:param_one).should be_true
    end

    it "should return true when setter exists and is accessible" do
      model.attr_accessible(:param_one)
      subject.accessible?(:param_one).should be_true
    end
  end

  describe "#attributes=" do
    it "should accept set hash of attributes" do
      subject.attributes = {:param_one => "hello"}
      subject.param_one.should == "hello"
    end

    it "should accept both string and symbols for keys" do
      subject.attributes = {"param_one" => "hello"}
      subject.param_one.should == "hello"
    end

    it "should not set non-existant attributes" do
      lambda {
        subject.attributes = {"wtf" => "omg"}
      }.should_not raise_error
    end

    it "should not access inaccessible attributes" do
      model.attr_accessible :param_two
      subject.attributes = {:param_one => "hello", :param_two => "hi"}
      subject.param_one.should be_blank
      subject.param_two.should == "hi"
    end
  end
end