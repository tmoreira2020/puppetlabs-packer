class packer::networking::params {

  case $::osfamily {
    debian: {
      $udev_rule        = '/etc/udev/rules.d/70-persistent-net.rules'
      $udev_rule_gen    = '/lib/udev/rules.d/75-persistent-net-generator.rules'
    }

    redhat: {
      case $::operatingsystemrelease {
        '7.0.1406', '7.1.1503': {
          case $::provisioner {
            'virtualbox': { $interface_script = '/etc/sysconfig/network-scripts/ifcfg-enp0s3' }
            'vmware':     { $interface_script = '/etc/sysconfig/network-scripts/ifcfg-ens33' }
          }

          $udev_rule        = '/etc/udev/rules.d/70-persistent-net.rules'
          $udev_rule_gen    = '/lib/udev/rules.d/75-persistent-net-generator.rules'
        }

        5.10, 5.11: {
          $interface_script = '/etc/sysconfig/network-scripts/ifcfg-eth0'
          $udev_rule        = '/etc/udev/rules.d/70-persistent-net.rules'
        }

        21, 22: {
          case $::provisioner {
            'virtualbox': { $interface_script = '/etc/sysconfig/network-scripts/ifcfg-enp0s3' }
            'vmware':     { $interface_script = '/etc/sysconfig/network-scripts/ifcfg-ens33' }
          }
        }

        default: {
          $interface_script = '/etc/sysconfig/network-scripts/ifcfg-eth0'
          $udev_rule        = '/etc/udev/rules.d/70-persistent-net.rules'
          $udev_rule_gen    = '/lib/udev/rules.d/75-persistent-net-generator.rules'
        }
      }
    }

    default: {
      fail( "Unsupported platform: ${::osfamily}/${::operatingsystem}" )
    }
  }

}
