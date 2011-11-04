require 'spec_helper'

describe RGovData::FileService do

  let(:dataset_key) { 'file' }
  let(:sample_file) { mock_file_path('sample.csv') }
  let(:service) { RGovData::FileService.new({:uri=>sample_file,:type=>'file'}) }


  describe "#dataset_keys" do
    let(:expect) { [dataset_key] }
    subject { service.dataset_keys }
    it { should eql(expect) }
  end

  describe "#native_instance" do
  end

  describe "#datasets" do
    subject { service.datasets }
    it { should be_a(Array) }
    its(:first) { should be_a(RGovData::FileDataSet) }
  end

end