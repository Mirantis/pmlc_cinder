# == Class: pmlc_cinder::service
#
# Class to configure cinder services on controller
#
# === Authors
#
# Scott Brimhall <sbrimhall@mirantis.com>
#
# === Copyright
#
# Copyright 2015 Mirantis Inc, unless otherwise noted.
#
class pmlc_cinder::service (
  $use_ceph = $::pmlc_cinder::use_ceph,
) inherits ::pmlc_cinder {

  $service = [
    'cinder-api',
    'cinder-scheduler',
    'cinder-backup',
    'cinder-volume'
  ]

  $file_lines = $use_ceph ? {
    /true/ => [
      'cinder_api-paste_tenant',
      'cinder_api-paste_password',
      'cinder_volume_group',
      'cinder_iscsi_helper',
      'cinder_volume_driver',
      'storage_availability_zone',
      'default_availability_zone',
      'cinder_rabbit_user',
      'cinder_rabbit_pass',
      'cinder_admin_user',
      'cinder_admin_pass',
      'cinder_db_connection',
    ],
    /false/ => [
      'cinder_api-paste_tenant',
      'cinder_api-paste_password',
      'cinder_volume_group',
      'cinder_iscsi_helper',
      'storage_availability_zone',
      'default_availability_zone',
      'cinder_rabbit_user',
      'cinder_rabbit_pass',
      'cinder_admin_user',
      'cinder_admin_pass',
      'cinder_db_connection',
    ]
  }

  service { $service:
    ensure    => 'running',
    enable    => true,
    require   => File_line[$file_lines],
    subscribe => File_line[$file_lines],
  }

}
