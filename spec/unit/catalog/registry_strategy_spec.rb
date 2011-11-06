require 'spec_helper'

describe RGovData::RegistryStrategy do

  {
    :sg => {:class => RGovData::InternalRegistry},
    :us => {:class => RGovData::InternalRegistry}
  }.each do |realm,options|
    context "with realm #{realm}" do
      describe "##get_instance" do
        subject { RGovData::RegistryStrategy.get_instance(realm) }
        it { should be_a(options[:class]) }
        its(:realm) { should eql(realm) }
        its(:load_services) { should be_a(Array) }
      end
    end
  end

  describe "##get_instance" do
    context "with a custom registry" do
      class RGovData::TestxxxRegistry < RGovData::RegistryStrategy
      end
      let(:realm) { :testxxx }
      subject { RGovData::RegistryStrategy.get_instance(realm) }
      it { should be_a(RGovData::TestxxxRegistry) }
    end
  end

  describe "##available_realms" do
    subject { RGovData::RegistryStrategy.available_realms }
    it { should be_a(Array) }
    it "should include supported realms" do
      supported_realms.each do |realm|
        subject.should include(realm)
      end
    end
  end

  describe "#load_services" do
    subject { RGovData::RegistryStrategy.new.load_services}
    it { should eql([]) }
  end

  describe "#realm" do
    let(:realm) { :xy }
    subject { RGovData::RegistryStrategy.new(realm) }
    its(:realm) { should eql(realm) }
  end

end
