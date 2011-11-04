require 'spec_helper'

describe RGovData::OdataDataSet do

  let(:credentialset) { 'basic' }
  let(:dataset_key) { 'Test' }
  let(:service) { RGovData::OdataService.new({:uri=>'uri',:type=>'odata',:credentialset=>credentialset}) }
  let(:dataset) { RGovData::OdataDataSet.new({:dataset_key=>dataset_key},service) }

  before {
    # These tests won't call on a real service
    OData::Service.any_instance.stub(:build_collections_and_classes).and_return(nil)
    RGovData::Config.stub(:default_config_file).and_return(mock_configfile_path)
    RGovData::Config.instance.load_default_config
  }

  describe "#native_dataset_key" do
    let(:expect) { 'TestSet' }
    subject { dataset.native_dataset_key }
    it { should eql(expect) }
  end

end