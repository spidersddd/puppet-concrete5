class concrete5::config inherits concrete5 {

  file { [
    "${docroot_dir}/packages",
    "${docroot_dir}/application/config",
    "${docroot_dir}/application/files",
    "${docroot_dir}/application/themes",
    ]:
    ensure => directory,
    mode   => '+w',
  }

  file { "${install_dir}/concrete5":
    ensure => link,
    target => $docroot_dir,
  }

  if ( $theme_name ) {

    file { "${docroot_dir}/application/themes/${theme_name}":
      ensure => directory,
      mode   => '+w',
    }

  }

}
