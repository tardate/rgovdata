require 'spec_helper'

describe RGovData::Catalog do

  supported_realms.each do |realm|
    context "with realm #{realm}" do
      let(:catalog) { RGovData::Catalog.new(realm) }
      subject { catalog }
      its(:realm) { should eql(realm) }
      describe "#services" do
        subject { catalog.services }
        it { should be_a(Array) }
        its(:first) { should be_a(RGovData::ServiceListing) }
      end
    end
  end

  describe "#get_service" do
    let(:catalog) { RGovData::Catalog.new(:sg) }
    subject { catalog.get_service(key) }
    context "with multiple matches" do
      let(:key) { 'l' }
      it { should be_a(Array) }
      its(:first) { should be_a(RGovData::ServiceListing) }
    end
    context "with single match" do
      let(:key) { 'nlb' }
      it { should be_a(RGovData::ServiceListing) }
      its(:realm) { should eql(:sg) }
      its(:key) { should eql(key) }
    end
  end

  describe "#realms" do
    let(:catalog) { RGovData::Catalog.new }
    its(:realms) { should be_a(Array) }
    supported_realms.each do |realm|
      its(:realms) { should include(realm) }
    end
  end

  describe "##get" do
    subject { RGovData::Catalog.get(key) }
    context "with realm only" do
      let(:key) { '//sg' }
      it { should be_a(RGovData::Catalog) }
      its(:realm) { should eql(:sg) }
    end
    context "with realm and service" do
      let(:key) { '//sg/nlb' }
      it { should be_a(RGovData::ServiceListing) }
      its(:realm) { should eql(:sg) }
      its(:key) { should eql('nlb') }
    end
  end

end
