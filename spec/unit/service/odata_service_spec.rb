require 'spec_helper'

describe RGovData::OdataService do

  let(:credentialset) { 'basic' }
  let(:service) { RGovData::OdataService.new({:uri=>'uri',:type=>'odata',:credentialset=>credentialset}) }

  before {
    # These tests won't call on a real service
    OData::Service.any_instance.stub(:build_collections_and_classes).and_return(nil)
    RGovData::Config.stub(:default_config_file).and_return(mock_configfile_path)
    RGovData::Config.instance.load_default_config
  }

  describe "#native_instance" do
    subject { service.native_instance }
    it { should be_a(OData::Service) }

    context "with basic credentials" do
      subject { service.native_instance.instance_variable_get(:@rest_options) }
      it "should have user set" do
        subject[:user].should_not be_nil
      end
      it "should have password set" do
        subject[:password].should_not be_nil
      end
    end

    context "with projectnimbus credentials" do
      let(:credentialset) { 'projectnimbus' }
      subject { service.native_instance.instance_variable_get(:@rest_options) }
      it "should have headers set" do
        subject[:headers].should_not be_nil
      end
    end
  end

  describe "#datasets" do
    
  end

end