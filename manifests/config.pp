# == Class: pmlc_cinder::config
#
# Class to manage cinder configuration file
#
# === Authors
#
# Scott Brimhall <sbrimhall@mirantis.com>
#
# === Copyright
#
# Copyright 2015 Mirantis Inc, unless otherwise noted.
#
class pmlc_cinder::config (
  $debug                     = $::pmlc_cinder::debug,
  $iscsi_helper              = $::pmlc_cinder::iscsi_helper,
  $volume_group              = $::pmlc_cinder::volume_group,
  $use_ceph                  = $::pmlc_cinder::use_ceph,
  $storage_availability_zone = $::pmlc_cinder::storage_availability_zone,
  $default_availability_zone = $::pmlc_cinder::default_availability_zone,
  $rabbit_user               = $::pmlc_cinder::rabbit_user,
  $rabbit_pass               = $::pmlc_cinder::rabbit_pass,
  $admin_user                = $::pmlc_cinder::admin_user,
  $admin_password            = $::pmlc_cinder::admin_password,
  $admin_tenant_name         = $::pmlc_cinder::admin_tenant_name,
  $database_user             = $::pmlc_cinder::database_user,
  $database_password         = $::pmlc_cinder::database_password,
  $management_vip            = $::pmlc_cinder::management_vip,
) inherits ::pmlc_cinder {

  $apipaste       = '/etc/cinder/api-paste.ini'
  $conf           = '/etc/cinder/cinder.conf'

  file_line { 'cinder_api-paste_tenant':
    path  => $apipaste,
    line  => "admin_tenant_name=${admin_tenant_name}",
    match => '^admin_tenant_name.*$',
  }

  file_line { 'cinder_api-paste_password':
    path  => $apipaste,
    line  => "admin_user=${admin_user}",
    match => '^admin_user.*$',
  }

  file_line { 'cinder_volume_group':
    path  => $conf,
    line  => "volume_group=${volume_group}",
    match => '^volume_group.*$',
  }

  file_line { 'cinder_iscsi_helper':
    path  => $conf,
    line  => "iscsi_helper=${iscsi_helper}",
    match => '^iscsi_helper.*$',
  }

  if $use_ceph == true {
    file_line { 'cinder_volume_driver':
      path  => $conf,
      line  => 'volume_driver=cinder.volume.drivers.rbd.RBDDriver',
      match => '^volume_driver.*$',
    }
  }

  file_line { 'storage_availability_zone':
    path  => $conf,
    line  => "storage_availability_zone=${storage_availability_zone}",
    match => '^storage_availability_zone.*$',
  }

  file_line { 'default_availability_zone':
    path  => $conf,
    line  => "default_availability_zone=${default_availability_zone}",
    match => '^default_availability_zone.*$',
  }

  file_line { 'cinder_rabbit_user':
    path  => $conf,
    line  => "rabbit_userid=${rabbit_user}",
    match => '^rabbit_userid.*$',
  }

  file_line { 'cinder_rabbit_pass':
    path  => $conf,
    line  => "rabbit_password=${rabbit_pass}",
    match => '^rabbit_password.*$',
  }

  file_line { 'cinder_admin_user':
    path  => $conf,
    line  => "admin_user=${admin_user}",
    match => '^admin_user.*$',
  }

  file_line { 'cinder_admin_pass':
    path  => $conf,
    line  => "admin_password=${admin_password}",
    match => '^admin_password.*$',
  }

  file_line { 'cinder_db_connection':
    path  => $conf,
    line  => "connection=mysql://${database_user}:${database_password}@${management_vip}/cinder?charset=utf8&read_timeout=60",
    match => '^connection=mysql:.*$',
  }
}
