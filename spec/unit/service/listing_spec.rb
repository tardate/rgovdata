require 'spec_helper'

describe RGovData::ServiceListing do

  describe "property:" do
    subject { RGovData::ServiceListing.new }
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

  describe "#as_param" do
    let(:realm) { :sg }
    let(:key) { 'key_name' }
    let(:expect) { '//sg/key_name' }
    let(:listing) { RGovData::ServiceListing.new }
    subject { listing }
    before do
      listing.realm = realm
      listing.key = key
    end
    its(:as_param) { should eql(expect) }
  end

  describe "#service" do
    [
      {:type => :odata, :transport => :odata, :uri => 'http://example.com', :expect_class => RGovData::ODataService },
      {:type => 'odata', :transport => 'odata', :uri => 'http://example.com', :expect_class => RGovData::ODataService },
      {:type => :csv, :transport => :get, :uri => 'http://example.com', :expect_class => RGovData::CsvService },
      {:type => 'csv', :transport => 'get', :uri => 'http://example.com', :expect_class => RGovData::CsvService },
      {:type => :dummy, :transport => :dummy, :uri => 'http://example.com', :expect_class => nil }
    ].each do |options|
      context "with type:#{options[:type]} transport:#{options[:transport]}" do
        let(:listing) { RGovData::ServiceListing.new }
        before do
          listing.type = options[:type]
          listing.transport = options[:transport]
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
end