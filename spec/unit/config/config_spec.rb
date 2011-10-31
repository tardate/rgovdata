require 'spec_helper'

describe RGovData::Config do

  describe "##default_config_file" do
    subject { RGovData::Config }
    its(:default_config_file) { should match(RGovData::Config::BASE_NAME) }
    it "should accept override parameter" do
      subject.default_config_file('foo').should match(/foo/)
    end
  end

  describe "##template" do
    subject { RGovData::Config.template }
    it { should be_a(String) }
  end

  describe "config file recognition" do
    let(:temp_config_file) { get_temp_file('rgovdata_config_test_') }
    after do
      File.delete(temp_config_file) if File.exists?(temp_config_file)
    end
    it "should not generate template file if auto-generation not enabled" do
      expect {
        RGovData::Config.new(temp_config_file,false)
      }.to raise_error(RGovData::Config::ConfigurationFileNotFound)
    end
    it "should generate template file if auto-generation is enabled" do
      expect {
        RGovData::Config.new(temp_config_file)
      }.to raise_error(RGovData::Config::ConfigurationFileInitialized)
      File.exists?(temp_config_file).should be_true
    end
  end

end