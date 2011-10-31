require 'ruby_odata'
class RGovData::ODataService < RGovData::Service

end

__END__

$LOAD_PATH.unshift('lib')
require 'rgovdata'
require 'ruby_odata'

cat = Rgovdata::Catalog.instance
cat.load_services
s = cat.services.first

rest_options = {:verify_ssl=>false, :headers=>{'AccountKey'=>'v6kny7D/KyTbg0KPoV3Omg==', 'UniqueUserID'=>'00000000000000000000000000000001'}}
svc = OData::Service.new s.uri,rest_options
svc.instance_variable_get(:@rest_options)
svc.instance_variable_set(:@rest_options,rest_options)

svc.LibrarySet
r = svc.execute
