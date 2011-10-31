require 'spec_helper'

describe RGovData::RegistryStrategy do
  {
    :sg => {:class => RGovData::InternalRegistry}
  }.each do |realm,options|
    context "with realm #{realm}" do
      describe "##instance_for_realm" do
        subject { RGovData::RegistryStrategy.instance_for_realm(realm) }
        it { should be_a(options[:class]) }
        its(:realm) { should eql(realm) }
        its(:load_services) { should be_a(Array) }
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
