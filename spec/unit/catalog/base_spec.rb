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

  context "without a realm specified" do
    let(:catalog) { RGovData::Catalog.new(nil) }

    describe "#key" do
      subject { catalog.key }
      it { should be_nil }
    end

    describe "#realms" do
      subject { catalog.realms }
      it { should be_a(Array) }
      its(:first) { should be_a(RGovData::Catalog) }
    end
    
    describe "#to_s" do
      subject { catalog.to_s }
      it { should be_a(String) }
    end

    describe "#find_by_key" do
      ['s','sg'].each do |key|
        context "with match on #{key}" do
          subject { catalog.find_by_key(key) }
          it { should be_a(RGovData::Catalog) }
          its(:realm) { should eql(:sg) }
          it { subject.key.to_s.should match(key) }
        end
      end
    end
    
    describe "#find_all_by_key" do
      ['s','sg'].each do |key|
        context "with match on #{key}" do
          subject { catalog.find_all_by_key(key) }
          it { should be_a(Array) }
          its(:first) { should be_a(RGovData::Catalog) }
        end
      end
    end

    describe "#records" do
      subject { catalog.records }
      it { should be_a(Array) }
      its(:first) { should be_a(RGovData::Catalog) }
    end

  end

  context "with a realm specified" do
    let(:catalog) { RGovData::Catalog.new(:sg) }

    describe "#key" do
      subject { catalog.key }
      it { should eql(:sg) }
    end

    describe "#find_by_key" do
      ['l','nlb'].each do |key|
        context "with match on #{key}" do
          subject { catalog.find_by_key(key) }
          it { should be_a(RGovData::ServiceListing) }
          its(:realm) { should eql(:sg) }
          its(:key) { should match(key) }
        end
      end
    end
    
    describe "#find_all_by_key" do
      ['l','nlb'].each do |key|
        context "with match on #{key}" do
          subject { catalog.find_all_by_key(key) }
          it { should be_a(Array) }
          its(:first) { should be_a(RGovData::ServiceListing) }
        end
      end
    end

    describe "#records" do
      subject { catalog.records }
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

  context "enumerable catalog item" do
    let(:resource) { RGovData::Catalog.new(nil) }
    let(:records) { RGovData::Catalog.new(nil).records }
    subject { resource }
    describe "#entries" do
      subject { resource.entries }
      it { should be_a(Array) }
      it { should == records }
    end
    describe "#[]" do
      subject { resource[0] }
      it { should  eql(records.first) }
    end
    describe "#first" do
      subject { resource.first }
      it { should == records.first }
    end
  end

end
