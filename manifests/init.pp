# == Class: concrete5
#
# Full description of class concrete5 here.
#
# === Parameters
#
# [*version*]
#   Defaults to 'latest' which points to the newest known supported version.
#   The version of Concrete5 to install. Currently only supports 5.7. See
#   install.pp for a list of all supported versions.
#
# [*install_dir*]
#   Defaults to /opt
#   Where to install Concrete5. This module will create a directory named
#   ${install_dir}/concrete5${version} and a symlink to it under
#   ${install_dir}/concrete5
#
# [*theme_name*]
#   (Optional)
#   If specified, this module will create a writable empty directory under
#   ${install_dir}/concrete5/application/themes/${theme_name}
#
# === Examples
#
#  class { 'concrete5':
#    version     => '5.7.2.1',
#    install_dir => '/opt',
#    theme_name  => 'my_theme',
#  }
#
# === Authors
#
# Bryan Cornies <bryan@sixsquarestudio.com>
# Troy Klein    <spidersddd@gmail.com>
#
#
class concrete5 (
  Optional[String] $theme_name,
  String $version,
  String $install_dir,
  Variant[String, Array] $packages,
) {

  case $facts['os']['family'] {
    'Debian': { }
    default: {
      fail("Module ${name} does not support ${facts['os']['family']}!")
    }
  }

  $docroot_dir  = "${install_dir}/concrete${version}"

  class {'concrete5::install': }
  -> class { 'concrete5::config': }

}
