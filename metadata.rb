name 'windows-services'
maintainer 'Tristan Morgans'
maintainer_email 'tristan@vibrato.com.au'
license 'MIT'
description 'Installs/Configures windows-services'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
if respond_to?(:source_url)
  source_url 'https://github.com/tristanmorgan/'\
  'cookbook-windows-services'
end
if respond_to?(:issues_url)
  issues_url 'https://github.com/tristanmorgan/'\
  'cookbook-windows-services/issues'
end
version '0.1.0'
supports 'windows'
chef_version '>= 12.0' if respond_to?(:chef_version)
