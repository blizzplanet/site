require 'spec_helper'

class TestResource < BaseModel
  property :key_id, Serial
  property :field, String
end

DataMapper.auto_migrate!

class TestResourcesController < ApplicationController
  include Traits::Controller::Resource 
end

describe TestResourcesController do
  include RSpec::Rails::ControllerExampleGroup
  subject { controller }

  # resource methods
  context "#resource_class" do
    it "should try to guess the class" do
      subject.send(:resource_class).should == TestResource
    end
  end

  context "#resource_name" do
    it "should guess resource name from resource class" do
      subject.send(:resource_name).should == "test_resource"
    end
  end

  context "#resource_identifier" do
    it "should return resource name symbol" do
      subject.send(:resource_identifier).should == :test_resource
    end
  end

  context "#resource" do
    it "should return instance variable with given resource_name" do
      subject.instance_variable_set('@test_resource', 1)
      subject.send(:resource).should == 1
    end
  end

  context "#resource=" do
    it "should set instance variable with given resource_name" do
      subject.send(:resource=, 1)
      subject.instance_variable_get('@test_resource').should == 1
    end
  end

  context "#resources" do
    it "should return instance variable with given resource_name" do
      subject.instance_variable_set('@test_resources', 1)
      subject.send(:resources).should == 1
    end
  end

  context "#resources=" do
    it "should set instance variable with given resource_name" do
      subject.send(:resources=, 1)
      subject.instance_variable_get('@test_resources').should == 1
    end
  end

  context "#new_resource_attributes" do
    it "should return params for new resource" do
      subject.stub!(:params).and_return(:test_resource => {:field => "wtf"})
      subject.send(:new_resource_attributes).should == {:field => "wtf"}
    end

    it "should return empty hash if no params provided" do
      subject.send(:new_resource_attributes).should == {}
    end
  end

  context "#resource_key" do
    it "should return a key field for resource model" do
      subject.send(:resource_key).should == :key_id
    end
  end
  

  # filters
  context "#build_resource" do
    it "should set resource to a new record by default" do
      subject.send(:build_resource)
      subject.send(:resource).should be_a(TestResource)
      subject.send(:resource).should be_new
    end

    it "should make use of request params" do
      subject.stub!(:params).and_return(:test_resource => {:field => "Haba"})
      subject.send(:build_resource)
      subject.send(:resource).should be_a(TestResource)
      subject.send(:resource).should be_new
      subject.send(:resource).field.should == "Haba"
    end
  end

  context "#update_resource" do
    it "should update resource attributes from params" do
      subject.send(:build_resource)
      subject.send(:resource).should be_a(TestResource)
      subject.send(:resource).should be_new
      subject.stub!(:params).and_return(:test_resource => {:field => "Haba"})
      subject.send(:update_resource)
      subject.send(:resource).field.should == "Haba"
    end
  end

  context "#fetch_resource" do
    let(:resource) { TestResource.create(:field => "wtf") }
    it "should use id from params hash to find a resource" do
      subject.stub!(:params).and_return(:id => resource.key_id)
      subject.send(:fetch_resource).should == resource
    end

    it "should be possible to use non-standard key for lookup" do
      subject.stub!(:resource_key).and_return(:field)
      subject.stub!(:params).and_return(:id => resource.field)
      subject.send(:fetch_resource).should == resource
    end

    it "should not raise an error if not found and using non-banged version" do
      subject.should_not_receive(:not_found!)
      subject.send(:fetch_resource)
    end

    it "should raise an error if not found and using banged version" do
      subject.should_receive(:not_found!)
      subject.send(:fetch_resource!)   
    end
  end

  context "#find_resource" do
    let(:resource) { TestResource.create(:field => "wtf") }
    it "should assign ivar" do
      subject.stub!(:params).and_return(:id => resource.key_id)
      subject.send(:find_resource)
      subject.instance_variable_get(:@test_resource).should == resource
    end

    it "should not raise an error if not found and using non-banged version" do
      subject.should_not_receive(:not_found!)
      subject.send(:find_resource)
    end

    it "should raise an error if not found and using banged version" do
      subject.should_receive(:not_found!)
      subject.send(:find_resource!)
    end
  end

  context "#find_resources" do
    let(:resources) { ("a".."f").map {|c| TestResource.create(:field => c)} }
    before(:each) { resources }
    it "should find all resources by default" do
      subject.send(:find_resources)
      ivar = subject.instance_variable_get(:@test_resources)
      resources.each {|r| ivar.should include(r) }      
    end

    it "should use #resource_scope" do
      subject.stub!(:resource_scope).and_return(TestResource.all(:field.gt => "e"))
      subject.send(:find_resources)
      subject.instance_variable_get(:@test_resources).should == [resources.last]                  
    end
  end
end