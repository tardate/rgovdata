require 'spec_helper'

describe RGovData::Template do
  subject { RGovData::Template }
  it { should respond_to(:get) }

  [
    { :name => 'config_template.yml', :realm => nil, :expect => 'credentials'},
    { :name => 'registry.yml', :realm => 'sg', :expect => 'description'},
    { :name => 'registry.yml', :realm => :sg, :expect => 'description'},
    { :name => 'registry.yml', :realm => 'zz', :expect => nil},
    { :name => 'not_found.yml', :realm => nil, :expect => nil}
  ].each do |options|
    context "with #{options[:realm]}:#{options[:name]}" do

      describe "##path" do
        subject { RGovData::Template.path(options[:name],options[:realm]) }
        it { File.exists?(subject).should == options[:expect].present? }
      end

      describe "##get" do
        subject { RGovData::Template.get(options[:name],options[:realm]) }
        if options[:expect]
          it { should include(options[:expect]) }
        else
          it { should be_nil }
        end
      end

    end
  end
end
