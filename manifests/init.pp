# == Class: pmlc_cinder
#
# Class to setup and manage cinder
#
# === Authors
#
# Scott Brimhall <sbrimhall@mirantis.com>
#
# === Copyright
#
# Copyright 2015 Mirantis Inc, unless otherwise noted.
#
class pmlc_cinder (
  $debug                     = $::pmlc_cinder::params::debug,
  $iscsi_helper              = $::pmlc_cinder::params::iscsi_helper,
  $volume_group              = $::pmlc_cinder::params::volume_group,
  $use_ceph                  = $::pmlc_cinder::params::use_ceph,
  $storage_availability_zone = $::pmlc_cinder::params::storage_availability_zone,
  $default_availability_zone = $::pmlc_cinder::params::default_availability_zone,
  $rabbit_user               = $::pmlc_cinder::params::rabbit_user,
  $rabbit_pass               = $::pmlc_cinder::params::rabbit_pass,
  $admin_user                = $::pmlc_cinder::params::admin_user,
  $admin_password            = $::pmlc_cinder::params::admin_password,
  $admin_tenant_name         = $::pmlc_cinder::params::admin_tenant_name,
  $database_user             = $::pmlc_cinder::params::database_user,
  $database_password         = $::pmlc_cinder::params::database_password,
  $management_vip            = $::pmlc_cinder::params::management_vip,
) inherits ::pmlc_cinder::params {

  validate_bool($debug)
  validate_string($iscsi_helper)
  validate_string($volume_group)
  validate_bool($use_ceph)
  validate_string($storage_availability_zone)
  validate_string($default_availability_zone)
  validate_string($rabbit_user)
  validate_string($rabbit_pass)
  validate_string($admin_user)
  validate_string($admin_password)
  validate_string($admin_tenant_name)
  validate_string($database_user)
  validate_string($management_vip)

  include ::pmlc_cinder::install
  include ::pmlc_cinder::config
  include ::pmlc_cinder::service

  # Order classes
  Class['::pmlc_cinder::install'] ->
  Class['::pmlc_cinder::config'] ->
  Class['::pmlc_cinder::service']

}
