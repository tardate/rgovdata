require 'spec_helper'

describe RGovData::Service do

  describe "##get_instance" do
    context "with unsupported options" do
      subject { RGovData::Service.get_instance('uri','type','transport','credentialset') }
      it { should be_nil }
    end
    context "with odata type" do
      subject { RGovData::Service.get_instance('uri','odata','odata','credentialset') }
      it { should be_a(RGovData::ODataService) }
    end
    context "with csv type" do
      subject { RGovData::Service.get_instance('uri','csv','get','credentialset') }
      it { should be_a(RGovData::CsvService) }
    end
  end
  
  let(:service) { RGovData::Service.new('uri','csv','get','credentialset') }

  describe "#native_instance" do
    subject { service.native_instance }
    it { should eql(service) }
  end

  describe "#datasets" do
    let(:mock_dataset_a) { 'mock_dataset_a' }
    let(:mock_dataset_b) { 'mock_dataset_b' }
    let(:mock_datasets) { [mock_dataset_a,mock_dataset_b] }
    before {
      service.stub(:datasets).and_return(mock_datasets)
    }
    subject { service.datasets }
    it { should be_a(Array) }
    it { should eql(mock_datasets) }
    describe "#get_dataset" do
      let(:key) { 'mock_dataset' }
      subject { service.get_dataset(key) }
      it { should eql(mock_datasets) }
      describe "#find" do
        subject { service.find(key) }
        it { should eql(mock_dataset_a) }
      end
      describe "#find_by_id" do
        subject { service.find_by_id(key) }
        it { should eql(mock_dataset_a) }
      end
    end

  end
end