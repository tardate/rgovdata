require 'spec_helper'

describe RGovData::DataSet do

  let(:dataset_key) { 'Test' }
  let(:service) { RGovData::Service.new({:type=>'dummy'}) }
  let(:dataset) { RGovData::DataSet.new({:dataset_key=>dataset_key},service) }

  describe "#limit" do
    subject { dataset.limit }
    context "not set" do
      it { should be_nil }
    end
    context "set" do
      let(:expect) { 5 }
      before { dataset.limit = 5 }
      it { should eql(expect) }
    end
  end

  describe "#records" do
    subject { dataset.records }
    context "with only a single result from load_records" do
      before {
        dataset.stub(:load_records).and_return('single result')
      }
      it { should eql('single result') }
    end
    context "with only a single result from load_records" do
      before {
        dataset.stub(:load_records).and_return(['result 1','result 2'])
      }
      it { should be_a(Array) }
    end
  end

end