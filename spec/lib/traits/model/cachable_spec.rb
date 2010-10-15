require 'spec_helper'

class CachableModel
  include ::DataMapper::Resource
  include ::Traits::Model::Cachable
  property :id, Serial
  property :version, Integer, :default => 0
  property :name, String
  timestamps :at
end

class LightweightCachableModel
  include ::DataMapper::Resource
  include ::Traits::Model::Cachable
  property :id, Serial
  property :name, String
end

DataMapper.auto_migrate!

describe Traits::Model::Cachable do
  describe "#cache_key" do
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

  describe ".class_cache" do
    it "should create ClassCache model when it doesn't exist" do
      ClassCache.destroy
      cc = CachableModel.class_cache
      cc.should be_a(ClassCache)  
      cc.should_not be_new
    end
    
    it "should set name to class name" do
      CachableModel.class_cache.class_name.should == "CachableModel"
    end
  end

  describe ".cache_key" do
    it "should include class name" do
      CachableModel.cache_key.should include("CachableModel")
    end
    
    it "should include .class_cache version" do
      cc = CachableModel.class_cache
      cc.version = 123
      cc.save
      CachableModel.cache_key.should include("123")
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
    
    it "should increment class version upon saving" do
      cc = subject.class.class_cache
      lambda {
        subject.name = "Puto Hey"
        subject.save
        cc.reload
      }.should change(cc, :version).by(1)
    end
    
    
    it "should increment class version upon destroying" do
      cc = subject.class.class_cache
      lambda {
        subject.destroy
        cc.reload
      }.should change(cc, :version).by(1)
    end
    
  end
end