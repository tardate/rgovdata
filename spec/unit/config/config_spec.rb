require 'spec_helper'

describe Rgovdata::Config do

  describe "##default_config_file" do
    subject { Rgovdata::Config }
    its(:default_config_file) { should match(Rgovdata::Config::BASE_NAME) }
    it "should accept override parameter" do
      subject.default_config_file('foo').should match(/foo/)
    end
  end

  describe "##template" do
    subject { Rgovdata::Config.template }
    it { should be_a(String) }
  end

  describe "config file recognition" do
    let(:temp_config_file) { get_temp_file('rgovdata_config_test_') }
    after do
      File.delete(temp_config_file) if File.exists?(temp_config_file)
    end
    it "should not generate template file if auto-generation not enabled" do
      expect {
        Rgovdata::Config.new(temp_config_file,false)
      }.to raise_error(Rgovdata::Config::ConfigurationFileNotFound)
    end
    it "should generate template file if auto-generation is enabled" do
      expect {
        Rgovdata::Config.new(temp_config_file)
      }.to raise_error(Rgovdata::Config::ConfigurationFileInitialized)
      File.exists?(temp_config_file).should be_true
    end
  end

end