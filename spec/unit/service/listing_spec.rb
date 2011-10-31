require 'spec_helper'

describe Rgovdata::ServiceListing do

  describe "property:" do
    subject { Rgovdata::ServiceListing.new }
    [
      :realm,:key,:name,:description,:keywords,:publisher,
      :uri,:license,:type,:transport,:credentials
    ].each do |property|
      describe property do
        it "should support setter and getter" do
          value = "x"
          subject.send("#{property}=",value)
          subject.send(property).should eql(value)
        end
      end
    end
  end

end