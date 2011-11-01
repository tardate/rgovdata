require 'spec_helper'

describe RGovData::Config do
  let(:config) { RGovData::Config.instance }

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

  describe "#load_config" do
    let(:temp_config_file) { get_temp_file('rgovdata_config_test_') }
    let(:config) { RGovData::Config.instance }
    after do
      File.delete(temp_config_file) if File.exists?(temp_config_file)
    end
    it "should not generate template file if auto-generation not enabled" do
      expect {
        config.load_config(temp_config_file,false)
      }.to raise_error(RGovData::Config::ConfigurationFileNotFound)
    end
    it "should generate template file if auto-generation is enabled" do
      expect {
        config.load_config(temp_config_file)
      }.to raise_error(RGovData::Config::ConfigurationFileInitialized)
      File.exists?(temp_config_file).should be_true
    end
  end

  describe "#credentialsets" do
    before :all do
      config.load_config(config.class.template_path,false)
    end
    {
      "basic" => { "username" => "_insert_your_username_here_", "password" => "your_password"},
      "projectnimbus" => { "AccountKey" => "_insert_your_key_here_", "UniqueUserID" => "00000000000000000000000000000001"}
    }.each do |credentialset,options|
      context credentialset do
        subject { config.credentialsets[credentialset] }
        it { should be_a(Hash)}
        options.keys.each do |key|
          describe key do
            subject { config.credentialsets[credentialset][key] }
            it { should eql(options[key]) }
          end
        end
      end
    end
  end

  {
    'projectnimbus_account_key' => {:credentialset=>'projectnimbus', :item=>'AccountKey'},
    'projectnimbus_unique_user_id' => {:credentialset=>'projectnimbus', :item=>'UniqueUserID'},
    'rgovdata_username' => {:credentialset=>'basic', :item=>'username'},
    'rgovdata_password' => {:credentialset=>'basic', :item=>'password'}
  }.each do |override,options|
    describe "#credentialsets ENV['#{override}'] override" do
      let(:key) { 'abcdefg' }
      before {
        ENV[override] = key
        config.load_config(config.class.template_path,false)
      }
      after { ENV[override] = nil }
      subject { config.credentialsets[options[:credentialset]][options[:item]] }
      it { should eql(key) }
    end
  end

end