# Params class for Cinder module
class pmlc_cinder::params {

  $debug                     = false
  $iscsi_helper              = 'tgtadm'
  $volume_group              = 'cinder-volumes'
  $use_ceph                  = false
  $storage_availability_zone = 'nova'
  $default_availability_zone = 'nova'
  $rabbit_user               = 'rabbit'
  $rabbit_pass               = 'rabbit'
  $admin_user                = 'cinder'
  $admin_password            = 'cinder'
  $admin_tenant_name         = 'services'
  $database_user             = 'cinder'
  $database_password         = 'cinder'
  $management_vip            = undef
}
