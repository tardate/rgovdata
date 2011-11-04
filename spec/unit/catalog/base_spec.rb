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
    subject { RGovData::Catalog.new(nil).realms }
    it { should be_a(Array) }
    it "should include supported realms" do
      subject.each do |realm_cat|
        supported_realms.should include(realm_cat.realm)
      end
    end
  end

  describe "#to_s" do
    its(:to_s) { should be_a(String) }
  end

  describe "#records" do
    context "without realm" do
      subject { RGovData::Catalog.new(nil).records }
      it { should be_a(Array) }
      its(:first) { should be_a(RGovData::Catalog) }
    end
    context "with realm" do
      subject { RGovData::Catalog.new(supported_realms.first).records }
      it { should be_a(Array) }
      its(:first) { should be_a(RGovData::ServiceListing) }
    end
  end

  describe "##get" do
    subject { RGovData::Catalog.get(key) }
    context "with nil selector" do
      let(:key) { nil }
      it { should be_a(RGovData::Catalog) }
      its(:realm) { should be_nil }
    end
    context "with blank selector" do
      let(:key) { '' }
      it { should be_a(RGovData::Catalog) }
      its(:realm) { should be_nil }
    end
    context "with no realm" do
      let(:key) { '//' }
      it { should be_a(RGovData::Catalog) }
      its(:realm) { should be_nil }
    end
    context "with realm only" do
      ['//sg','::sg'].each do |key_test|
        let(:key) { key_test}
        it { should be_a(RGovData::Catalog) }
        its(:realm) { should eql(:sg) }
      end
    end
    context "with realm and service" do
      let(:key) { '//sg/nlb' }
      it { should be_a(RGovData::ServiceListing) }
      its(:realm) { should eql(:sg) }
      its(:key) { should eql('nlb') }
    end
  end

end
