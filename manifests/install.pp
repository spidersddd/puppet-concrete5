class concrete5::install inherits concrete5 {
  $archive_file = $concrete5::archive_file
  $install_dir  = $concrete5::install_dir
  $docroot_dir  = $concrete5::docroot_dir
  $version      = $concrete5::version
  $packages     = $concrete5::packages

  $download_url = lookup("concrete5::download_url::${version}")
  $archive_file = "${install_dir}/concrete${version}.zip"

  exec { 'download concrete5':
    command => "wget -O ${archive_file} ${download_url}",
    cwd     => $install_dir,
    creates => $docroot_dir,
    path    => ['/usr/bin'],
    require => Packages[$packages],
  }

  exec { 'unpack concrete5':
    command => "unzip -o ${archive_file}",
    cwd     => $install_dir,
    creates => $docroot_dir,
    path    => ['/usr/bin'],
    require => Exec['download concrete5'],
  }

  file { $archive_file:
    ensure  => absent,
    require => Exec['unpack concrete5'],
  }

}
