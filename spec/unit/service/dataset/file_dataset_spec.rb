require 'spec_helper'
include MocksHelper

describe RGovData::FileDataSet do

  let(:dataset_key) { 'file' }
  let(:sample_file) { mock_file_path('sample.csv') }
  let(:service) { RGovData::FileService.new({:uri=>sample_file,:type=>dataset_key}) }
  let(:dataset) { RGovData::FileDataSet.new({:dataset_key=>dataset_key},service) }
  
  describe "#native_dataset_key" do
    let(:expect) { dataset_key }
    subject { dataset.native_dataset_key }
    it { should eql(expect) }
  end

  describe "#attributes" do
    let(:expect) { ['row'] }
    subject { dataset.attributes }
    it { should eql(expect) }
  end

  describe "#records" do
    subject { dataset.records }
    it { should be_a(StringIO) }
  
    context "with a record_limit" do
      let(:record_limit) { 3 }
      before {
        dataset.limit = record_limit
      }
      subject { dataset.records(true) }
      it { should be_a(Array) }
      its(:first) { should be_a(String) }
      its(:count) { should eql(record_limit) }
    end
  end


end