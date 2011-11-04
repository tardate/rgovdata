require 'spec_helper'

describe RGovData::Service do

  describe "##get_instance" do
    context "with unsupported options" do
      subject { RGovData::Service.get_instance({:uri=>'uri',:type=>'type',:transport=>'transport',:credentialset=>'credentialset'}) }
      it { should be_nil }
    end
    context "with odata type" do
      subject { RGovData::Service.get_instance({:uri=>'uri',:type=>'odata',:transport=>'odata',:credentialset=>'credentialset'}) }
      it { should be_a(RGovData::OdataService) }
    end
    context "with csv type" do
      subject { RGovData::Service.get_instance({:uri=>'uri',:type=>'csv',:transport=>'get',:credentialset=>'credentialset'}) }
      it { should be_a(RGovData::FileService) }
    end
  end
  
  let(:service) { RGovData::Service.new({:realm=>:sg, :service_key=>'service_name', :uri=>'uri',:type=>'csv',:transport=>'get',:credentialset=>'credentialset'}) }
  subject { service }
  
  it_behaves_like "includes common config"

  describe "#native_instance" do
    subject { service.native_instance }
    it { should eql(service) }
  end

  describe "#meta_attributes" do
    subject { service.meta_attributes }
    it { should be_a(Array) }
  end

  describe "#initialization_hash" do
    subject { service.initialization_hash }
    let(:keys) { service.initialization_hash.keys }
    it { should be_a(Hash) }
    it "should contain members for all attributes" do
      service.meta_attributes.each do |attribute|
        keys.should include(attribute)
      end
    end
  end

  describe "#id" do
    let(:expect) { '//sg/service_name' }
    its(:id) { should eql(expect) }
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

    describe "#records" do
      subject { service.records }
      it { should eql(mock_datasets) }
    end

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