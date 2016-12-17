# BOSH-deployed ISC DHCP Server

This BOSH release can be used to deploy a DHCP server.

### Procedure

```
git clone git@github.com:pivotal-cf-experimental/dhcp-server-release.git
cd dhcp-server-release
bosh create release
bosh upload release
bosh deployment your-manifest-dhcpd.yml
bosh deploy
```

### Jobs

#### 0. `dhcpd`

ISC DHCP Server.

Properties:

* `config_file` — `dhcpd` [configuration file](https://access.redhat.com/documentation/en-US/Red_Hat_Enterprise_Linux/3/html/System_Administration_Guide/s1-dhcp-configuring-server.html). Placed in `/var/vcap/jobs/dhcpd/etc/dhcpd.conf`.

#### 1. `dhclient_ipv6`

`dhclient` for IPv6. Typically used for IaaSes that require
`dhclient` to acquire IPv6 addresses (e.g. AWS). Does not
required `dhcpd` job.

This should be paired with a job that enables IPv6 in the kernel, e.g.
[os-conf-release](https://github.com/cloudfoundry/os-conf-release)'s
`enable_ipv6` job.

Properties:

* `interface` — the ethernet interface to listen to, defaults to randomly-selected non-loopback interface. Typically `eth0`

### Sample Deployment

A sample manifest is available in the `examples` subdirectory.

### Caveats

#### `dhcpd`

We don't believe the `dhcpd` job will work on Amazon AWS; AWS does [not
support broadcast](http://aws.amazon.com/vpc/faqs/), and DHCP relies on
broadcast packets.

Be sure that the IP addresses that your DHCP server is configured to give out does not overlap with the IP addresses that BOSH is configured to give out.

#### `dhclient_ipv6`

There can only be one `dhclient_ipv6` job on a VM, and it can only bind
to one interface.
