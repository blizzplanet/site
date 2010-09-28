require 'spec_helper'

class TestResource < BaseModel
  set_table_name :articles
end

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
      subject.stub!(:params).and_return(:test_resource => {:title => "wtf"})
      subject.send(:new_resource_attributes).should == {:title => "wtf"}
    end

    it "should return empty hash if no params provided" do
      subject.send(:new_resource_attributes).should == {}
    end
  end

  context "#resource_key" do
    it "should return a key field for resource model" do
      subject.send(:resource_key).should == :id
    end
  end


  # filters
  context "#build_resource" do
    it "should set resource to a new record by default" do
      subject.send(:build_resource)
      subject.send(:resource).should be_a(TestResource)
      subject.send(:resource).should be_a_new_record
    end

    it "should make use of request params" do
      subject.stub!(:params).and_return(:test_resource => {:title => "Haba"})
      subject.send(:build_resource)
      subject.send(:resource).should be_a(TestResource)
      subject.send(:resource).should be_a_new_record
      subject.send(:resource).title.should == "Haba"
    end
  end

  context "#update_resource" do
    it "should update resource attributes from params" do
      subject.send(:build_resource)
      subject.send(:resource).should be_a(TestResource)
      subject.send(:resource).should be_a_new_record
      subject.stub!(:params).and_return(:test_resource => {:title => "Haba"})
      subject.send(:update_resource)
      subject.send(:resource).title.should == "Haba"
    end
  end

  context "#fetch_resource" do
    let(:resource) { TestResource.create(:title => "wtf", :body_raw => "123") }
    it "should use id from params hash to find a resource" do
      subject.stub!(:params).and_return(:id => resource.id)
      subject.send(:fetch_resource).should == resource
    end

    it "should be possible to use non-standard key for lookup" do
      subject.stub!(:resource_key).and_return(:body_raw)
      subject.stub!(:params).and_return(:id => resource.body_raw)
      subject.send(:fetch_resource).should == resource
    end

    it "should not raise an error if not found and using non-banged version" do
      subject.should_not_receive(:not_found!)
      subject.send(:fetch_resource)
    end

    it "should call not found if not found and using banged version" do
      subject.should_receive(:not_found!)
      subject.send(:fetch_resource!)
    end
  end

  context "#find_resource" do
    let(:resource) { TestResource.create(:title => "wtf") }
    it "should assign ivar" do
      subject.stub!(:params).and_return(:id => resource.id)
      subject.send(:find_resource)
      subject.instance_variable_get(:@test_resource).should == resource
    end

    it "should not raise an error if not found and using non-banged version" do
      lambda {
        subject.send(:find_resource)
      }.should_not raise_error
    end

    it "should raise an error if not found and using banged version" do
      subject.should_receive(:not_found!)
      subject.send(:find_resource!)
    end
  end

  context "#find_resources" do
    let(:resources) { ("a".."f").map {|c| TestResource.create(:title => c)} }
    before(:each) { resources }
    it "should find all resources by default" do
      subject.send(:find_resources)
      ivar = subject.instance_variable_get(:@test_resources)
      resources.each {|r| ivar.should include(r) }
    end

    it "should use #resource_scope" do
      subject.stub!(:resource_scope).and_return(TestResource.where(["title > ?", "e"]))
      subject.send(:find_resources)
      subject.instance_variable_get(:@test_resources).should == [resources.last]
    end
  end
end