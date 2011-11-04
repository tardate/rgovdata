require 'spec_helper'

describe RGovData::ServiceListing do

  describe "property:" do
    subject { RGovData::ServiceListing.new }
    [
      :realm,:key,:name,:description,:keywords,:publisher,
      :uri,:license,:type,:credentialset
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

  describe "#id" do
    let(:realm) { :sg }
    let(:key) { 'key_name' }
    let(:expect) { '//sg/key_name' }
    let(:listing) { RGovData::ServiceListing.new }
    subject { listing }
    before do
      listing.realm = realm
      listing.key = key
    end
    its(:id) { should eql(expect) }
  end

  describe "#service" do
    [
      {:type => :odata, :uri => 'http://example.com', :expect_class => RGovData::OdataService },
      {:type => 'odata', :uri => 'http://example.com', :expect_class => RGovData::OdataService },
      {:type => :csv, :uri => 'http://example.com', :expect_class => RGovData::FileService },
      {:type => 'csv', :uri => 'http://example.com', :expect_class => RGovData::FileService },
      {:type => :dummy, :uri => 'http://example.com', :expect_class => nil }
    ].each do |options|
      context "with type:#{options[:type]}" do
        let(:listing) { RGovData::ServiceListing.new }
        before do
          listing.type = options[:type]
          listing.uri = options[:uri]
        end
        subject { listing.service }
        if options[:expect_class]
          it { should be_a(options[:expect_class]) }
        else
          it { should be_nil }
        end
      end
    end
  end

  describe "#datasets" do
    let(:listing) { RGovData::ServiceListing.new }
    let(:mock_datasets) { ['a','b'] }
    before {
      RGovData::Service.stub(:get_instance).and_return(RGovData::Service.new({:uri=>'uri',:type=>'type',:credentialset=>'credentialset'}))
      RGovData::Service.any_instance.stub(:datasets).and_return(mock_datasets)
    }
    subject { listing.datasets }
    it { should be_a(Array) }
    it { should eql(mock_datasets) }

    describe "#records" do
      subject { listing.records }
      it { should eql(mock_datasets) }
    end

    describe "#get_dataset" do
      let(:key) { 'key' }
      let(:mock_dataset_a) { 'mock_dataset_a' }
      let(:mock_dataset_b) { 'mock_dataset_b' }
      let(:mock_dataset) { [mock_dataset_a,mock_dataset_b] }
      before {
        RGovData::Service.any_instance.stub(:get_dataset).and_return(mock_dataset)
      }
      subject { listing.get_dataset(key) }
      it { should eql(mock_dataset) }
      describe "#find" do
        subject { listing.find(key) }
        it { should eql(mock_dataset_a) }
      end
      describe "#find_by_id" do
        subject { listing.find_by_id(key) }
        it { should eql(mock_dataset_a) }
      end
    end
  end

  describe "#to_s" do
    its(:to_s) { should be_a(String) }
  end

  
end