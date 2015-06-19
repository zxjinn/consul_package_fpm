# consul_package_fpm
Package Consul and Consul UI with FPM (Linux, x86_64). This only packages released versions.

## Usage
There are two scripts to assist in the building process [build_deb.sh](build_deb.sh) for Debian/Ubuntu systems and [build_rpm.sh](build_rpm.sh) for RHEL/CentOS systems (untested).

I use this to build new Consul packages with Jenkins `jenkins_build.sh` which only outputs Debian packages and is intended to be run on Debian-based systems with Ruby installed. If RVM is installed on the system it will attempt to use the version of Ruby found in [.ruby-version](.ruby-version), so ensure it's installed beforehand. Pull requests are welcomed for any changes.

All build scripts take the following environment variables:
* `BUILD_NUMBER` The build number of the package. Jenkins sets this automatically. For the default see: [build_number](build_number)
* `CONSUL_VERSION` The version of Consul and Consul UI to download and build. For the default see: [consul_version](consul_version)
* `PACKAGE_DESCRIPTION` The Consul description passed to FPM with `--description`. For the default see: [package_description](package_description)
* `PACKAGE_DESCRIPTION_UI` The Consul UI description passed to FPM with `--description`. For the default see: [package_description_ui](package_description_ui)
* `PACKAGE_HOMEPAGE` The homepage passed to FPM with `--url`. For the default see: [package_homepage](package_homepage)
* `PACKAGE_MAINTAINER` The maintainer name passed to FPM with `--maintainer`. For the default see: [package_maintainer](package_maintainer)
* `PACKAGE_VENDOR` The vendor name passed to FPM with `--vendor`. For the default see: [package_vendor](package_vendor)
