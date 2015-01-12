# ohai-plugins
Custom ohai plugins

## packages.rb
This will provide a list of installed packages and their versions.
If an update is available, that will also be reported.
##### JSON
````json
      {
        "name": "snmp-mibs",
        "version": "5.7.2.1-3.8"
      },
      {
        "name": "libstdc++48-devel",
        "version": "4.8.3+r212056-6.3",
        "update": "4.8.3+r212056-11.2"
      },
      {
        "name": "perl-Digest-SHA1",
        "version": "2.13-17.216"
      },
      {
        "name": "ntp",
        "version": "4.2.6p5-24.3",
        "update": "4.2.6p5-31.1"
      },
      {
        "name": "sysfsutils",
        "version": "2.1.0-151.65"
      },
````
