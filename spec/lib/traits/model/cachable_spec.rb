require 'spec_helper'

class CachableModel < TablelessModel
  attr_accessor :id, :name, :version, :updated_at, :created_at
  include ::Traits::Model::Cachable
  
  def version
    @version ||= 0
  end
  
end

class LightweightCachableModel < TablelessModel
  include ::Traits::Model::Cachable
  attr_accessor :id, :name
end


describe Traits::Model::Cachable do
  context "#cache_key" do
    subject { CachableModel.new(:name => "hello, world", :version => 42) }
    it "should include model class name" do
      subject.cache_key.should include(subject.class.name.to_s)
    end

    it "should include model key" do
      subject.cache_key.should include(subject.id.to_s)
    end

    it "should include model version" do
      subject.cache_key.should include(subject.version.to_s)
    end

    it "should include update timestamp" do
      subject.cache_key.should include(subject.updated_at.to_s)
    end

    it "should not choke when it is impossible to find some keys" do
      model = LightweightCachableModel.new(:name => "Hello")
      lambda { model.cache_key }.should_not raise_error
    end

    it "should not add nil keys" do
      subject.version = nil
      subject.cache_key.should_not include("nil")
    end

    it "should generate random key for non persisted models" do
      CachableModel.new.cache_key.should_not == CachableModel.new.cache_key
    end
  end

  context "callbacks" do
    subject { CachableModel.new }
    it "should increment versions upon saving" do
      lambda {
        subject.name = "Puto Hey"
        subject.save
      }.should change(subject, :version).by(1)
    end
  end
end