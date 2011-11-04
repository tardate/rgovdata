require 'pathname'

module MocksHelper
  def mock_file_path(key)
    Pathname.new(File.dirname(__FILE__)).join('..','fixtures',key).to_s
  end
  def mock_text(key)
    IO.read(mock_file_path(key))
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