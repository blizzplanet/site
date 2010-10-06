require "spec_helper"

describe Person do
  subject { Factory.build(:person) }
  context "validations:" do
    context "with valid attributes" do
      subject { Factory.build(:person) }
      it_should_behave_like "a valid model"
    end

    context "without name" do
      subject { Factory.build(:person, :name => "") }
      it_should_behave_like "a valid model"
    end

    context "without login" do
      subject { Factory.build(:person, :login => "") }
      it_should_behave_like "an invalid model"
    end

    context "without email" do
      subject { Factory.build(:person, :email => "") }
      it_should_behave_like "an invalid model"
    end

    context "without password" do
      context "before being saved" do
        subject { Factory.build(:person, :password => nil) }
        it_should_behave_like "an invalid model"
      end

      context "after being saved" do
        subject { Factory(:person).tap {|p| p.password = nil; p.save } }
        it_should_behave_like "a valid model"
      end
    end


    context "without password confirmation" do
      context "before being saved" do
        subject { Factory.build(:person, :password_confirmation => nil) }
        it_should_behave_like "an invalid model"
      end

      context "after being saved" do
        subject { Factory(:person).tap {|p| p.password = nil; p.password_confirmation = nil } }
        it_should_behave_like "a valid model"
      end
    end

    context "with non-unique email" do
      let!(:other_person) { Factory(:person) }
      subject { Factory.build(:person, :email => other_person.email) }
      it_should_behave_like "an invalid model"
    end
  end

  describe "#display_name" do
    subject { Factory(:person, :login => "doe", :name => "John Doe") }
    
    it "should return name plus login when both supplied" do
      subject.display_name.should == "John Doe (doe)"
    end

    it "should return login when no name supplied" do
      subject.name = ""
      subject.display_name.should == "doe"
    end
  end

end