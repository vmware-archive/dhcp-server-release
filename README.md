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

### Sample Deployment

A sample manifest is available in the `examples` subdirectory.

### vCenter Only

We don't believe it will work on Amazon AWS; AWS does [not support broadcast](http://aws.amazon.com/vpc/faqs/), and DHCP relies on broadcast packets. 

### Caveats

Be sure that the IP addresses that your DHCP server is configured to give out does not overlap with the IP addresses that BOSH is configured to give out.