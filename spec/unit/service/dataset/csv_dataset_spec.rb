require 'spec_helper'
include MocksHelper

describe RGovData::CsvDataSet do

  let(:dataset_key) { 'csv' }
  let(:sample_file) { mock_file_path('sample.csv') }
  let(:expect_row_count) { 820 }
  let(:expect_headers) { ["Src", "Eqid", "Version", "Datetime", "Lat", "Lon", "Magnitude", "Depth", "NST", "Region"] }

  let(:service) { RGovData::CsvService.new({:uri=>sample_file,:type=>'csv'}) }
  let(:dataset) { RGovData::CsvDataSet.new({:dataset_key=>dataset_key},service) }

  describe "#key" do
    let(:expect) { dataset_key }
    subject { dataset.key }
    it { should eql(expect) }
  end

  describe "#attributes" do
    subject { dataset.attributes }
    it { should eql(expect_headers) }
  end

  describe "#records" do
    subject { dataset.records }
    its(:count) { should eql(expect_row_count) }

    context "with a record_limit" do
      let(:record_limit) { 3 }
      before {
        dataset.limit = record_limit
      }
      subject { dataset.records(true) }
      it { should be_a(Array) }
      its(:first) { should be_a(CSV::Row) }
      its(:count) { should eql(record_limit) }
    end
  end
  

end