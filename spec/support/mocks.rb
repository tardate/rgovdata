module MocksHelper
  def mock_text(key)
    IO.read("#{File.dirname(__FILE__)}/../fixtures/#{key}")
  end
  def mock_xml(key)
    Nokogiri::XML(mock_text(key))
  end
end