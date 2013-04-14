NagiraActiveResource
======================

Rails side to Nagira API.

Since Nagira API in ActiveResource mode is not actually ActiveResource
compliant, there is a need to have component on the Rails side to
provide additional functionality to make it look like ActiveResource.

This module provides additional methods use Nagira together with
Rails and ActiveResource models.

Usage
===========

Define your models like

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ruby
class Host < NagiraActiveResource::Host
  self.site = "http://#{Rails::NAGIRA[:host] || localhost}:#{Rails::NAGIRA[:port] || 80}/_status/"
  self.element_name = "_host"
end

class Service < ActiveResource::Base
  self.site = "http://#{Rails::NAGIRA[:host] || localhost}:#{Rails::NAGIRA[:port] || 80}/_status/"
  self.element_name = "service"
end
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Add initializer in `config/initialiazers`

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ruby
require 'nagira_active_resource/lib/nagira_active_resource'

Rails::NAGIRA={ 
  host: 'localhost',
  port: 4567
}
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

License
===========

This project uses MIT-LICENSE.

Author
===========

Dmytro Kovalov
http://dmytro.github.com
dmytro.kovalov@gmail.com
