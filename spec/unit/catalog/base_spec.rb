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
      end
    end
  end

  describe "#realms" do
    let(:catalog) { RGovData::Catalog.new }
    its(:realms) { should be_a(Array) }
    supported_realms.each do |realm|
      its(:realms) { should include(realm) }
    end
  end
end
