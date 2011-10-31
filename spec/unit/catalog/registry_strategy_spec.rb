require 'spec_helper'

describe Rgovdata::RegistryStrategy do
  {
    :sg => {:class => Rgovdata::InternalRegistry}
  }.each do |realm,options|
    context "with realm #{realm}" do
      describe "##instance_for_realm" do
        subject { Rgovdata::RegistryStrategy.instance_for_realm(realm) }
        it { should be_a(options[:class]) }
        its(:realm) { should eql(realm) }
        its(:load_services) { should be_a(Array) }
      end
    end
  end

  describe "#load_services" do
    subject { Rgovdata::RegistryStrategy.new.load_services}
    it { should eql([]) }
  end

  describe "#realm" do
    let(:realm) { :xy }
    subject { Rgovdata::RegistryStrategy.new(realm) }
    its(:realm) { should eql(realm) }
  end

end
