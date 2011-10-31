require 'spec_helper'

describe Rgovdata::Template do
  subject { Rgovdata::Template }
  it { should respond_to(:get) }
  [
    { :name => 'config_template.yml', :realm => nil, :expect => 'credentials'},
    { :name => 'registry.yml', :realm => 'sg', :expect => 'description'},
    { :name => 'registry.yml', :realm => :sg, :expect => 'description'},
    { :name => 'registry.yml', :realm => 'zz', :expect => nil},
    { :name => 'not_found.yml', :realm => nil, :expect => nil}
  ].each do |options|
    context "with #{options[:realm]}:#{options[:name]}" do
      subject { Rgovdata::Template.get(options[:name],options[:realm]) }
      if options[:expect]
        it { should include(options[:expect]) }
      else
        it { should be_nil }
      end
    end
  end
end
