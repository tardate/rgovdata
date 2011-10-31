require 'spec_helper'
require 'getoptions'

describe Rgovdata::Shell do
  context "class" do
    subject { Rgovdata::Shell }
    it { should respond_to(:usage) }
  end

end
