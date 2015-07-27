# == Class: pmlc_cinder::install
#
# Install cinder packages
#
# Scott Brimhall [sbrimhall@mirantis.com]
#
# === Copyright
#
# Copyright 2015 Mirantis Inc, unless otherwise noted.
#
class pmlc_cinder::install {

  $packages = [
    'cinder-api',
    'cinder-backup',
    'cinder-common',
    'cinder-scheduler',
    'cinder-volume',
    'python-cinder',
    'python-cinderclient',
  ]

  package { $packages:
    ensure => 'present',
  }

}
