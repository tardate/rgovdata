require 'spec_helper'
require 'getoptions'

describe RGovData::Shell do
  context "class" do
    subject { RGovData::Shell }
    it { should respond_to(:usage) }
  end

end
