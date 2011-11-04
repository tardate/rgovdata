require 'spec_helper'

# This runs integration tests against the actual csv file service
# It uses credentials from the rgovdata.conf file in the project root folder
describe "Worldwide M1+ Earthquakes" do
  let(:config) { RGovData::Config.instance }
  before :all do
    config.load_config(integration_test_config_filename, {:generate_default => true,:required => true})
  end
  after :all do
    config.clear
  end

  describe "ServiceListing" do
    let(:id) { '//us/eqs7day-M1' }
    let(:dataset_key) { :csv }
    let(:expect_attributes) { ["Src", "Eqid", "Version", "Datetime", "Lat", "Lon", "Magnitude", "Depth", "NST", "Region"] }
    let(:record_class) { CSV::Row }

    let(:service_listing) { RGovData::Catalog.get(id) }

    subject { service_listing }
    it { should be_a(RGovData::ServiceListing) }

    describe "#service" do
      let(:service) { service_listing.service }
      subject { service }
      it { should be_a(RGovData::Service) }
      describe "#dataset_keys" do
        subject { service.dataset_keys }
        it { should include(dataset_key) }
      end
    end

    describe "#find" do
      let(:dataset) { service_listing.find(dataset_key) }
      subject { dataset }
      it { should be_a(RGovData::CsvDataSet) }
      describe "#attributes" do
        subject { dataset.attributes }
        it { should eql(expect_attributes) }
      end
      describe "#records" do
        let(:record_limit) { 3 }
        before {
          dataset.limit = record_limit
        }
        subject { dataset.records(true) }
        it { should be_a(Array) }
        its(:first) { should be_a(record_class) }
        its(:count) { should eql(record_limit) }
      end

    end
  end

end