require 'pathname'

module MocksHelper
  def mock_text(key)
    IO.read("#{File.dirname(__FILE__)}/../fixtures/#{key}")
  end
  def mock_xml(key)
    Nokogiri::XML(mock_text(key))
  end
  def mock_rails_root
    Pathname.new(File.dirname(__FILE__)).join('..','fixtures','rails_root')
  end
  def mock_configfile_path
    Pathname.new(File.dirname(__FILE__)).join('..','fixtures','rgovdata.conf').to_s
  end
  def mock_configfile_path_notfound
    Pathname.new(File.dirname(__FILE__)).join('..','fixtures','rgovdata-notfound.conf').to_s
  end
end