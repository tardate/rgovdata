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
    let(:expect) { nil }
    subject { dataset.attributes }
    it { should eql(expect) }
  end

  describe "#records" do
    subject { dataset.records }
    it { should be_a(StringIO) }
  end
  

end