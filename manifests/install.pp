class concrete5::install {

  $version = $concrete5::version ? {
    'latest' => '5.7.2.1',
    default  => $concrete5::version
  }

  $archive_file = "${concrete5::install_dir}/concrete${version}.zip"
  $docroot_dir  = "${concrete5::install_dir}/concrete${version}"

  # Concrete5 doesn't appear to have deterministic URLs, so we'll map versions
  # to URLs here.
  $download_url = $version ? {
    '5.7.2'   => 'http://www.concrete5.org/download_file/-/view/72447/',
    '5.7.2.1' => 'http://www.concrete5.org/download_file/-/view/73241/',
    default   => undef,
  }

  if !$download_url {
    fail("Unsupported version of Concrete5 specified: ${concrete5::version}. Please add to selector statement in install.pp.")
  }

  ensure_resource('package', 'wget', { ensure => installed })

  exec { 'download concrete5':
    command => "wget -O ${archive_file} ${download_url}",
    cwd     => $concrete5::install_dir,
    creates => $docroot_dir,
    path    => ['/usr/bin'],
  }

  exec { 'unpack concrete5':
    command => "unzip -o ${archive_file}",
    cwd     => $concrete5::install_dir,
    creates => $docroot_dir,
    path    => ['/usr/bin'],
  }

  file { "${concrete5::install_dir}/${archive_file}":
    ensure => absent,
  }

}
