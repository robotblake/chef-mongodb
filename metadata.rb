name             'mongodb'
maintainer       'Blake Imsland'
maintainer_email 'blake@retroco.de'
license          'MIT'
description      'Installs and configures mongodb'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

depends 'apt', '>= 1.8.2'

supports 'ubuntu'
supports 'debian'
