class concrete5::install inherits concrete5 {

  $version = $version ? {
    'latest' => '5.7.2.1',
    default  => $version
  }

  $archive_file = "${install_dir}/concrete${version}.zip"

  # Concrete5 doesn't appear to have deterministic URLs, so we'll map versions
  # to URLs here.
  $download_url = $version ? {
    '5.7.0'   => 'http://www.concrete5.org/download_file/-/view/70843/8497/',
    '5.7.0.1' => 'http://www.concrete5.org/download_file/-/view/70916/8497/',
    '5.7.0.3' => 'http://www.concrete5.org/download_file/-/view/71260/8497/',
    '5.7.2'   => 'http://www.concrete5.org/download_file/-/view/72447/',
    '5.7.2.1' => 'http://www.concrete5.org/download_file/-/view/73241/',
    default   => undef,
  }

  if !$download_url {
    fail("Unsupported version of Concrete5 specified: ${version}. Please add to selector statement in install.pp.")
  }

  ensure_resource(
    'package',
    [
      'wget',
      'php-gd',
      'php-pdo',
      'php-mysql',
    ],
    {
      ensure => installed,
    }
  )

  exec { 'download concrete5':
    command => "wget -O ${archive_file} ${download_url}",
    cwd     => $install_dir,
    creates => $docroot_dir,
    path    => ['/usr/bin'],
  }

  exec { 'unpack concrete5':
    command => "unzip -o ${archive_file}",
    cwd     => $install_dir,
    creates => $docroot_dir,
    path    => ['/usr/bin'],
  }

  file { $archive_file:
    ensure => absent,
  }

}
