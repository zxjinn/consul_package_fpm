# consul_package_fpm
Package consul with FPM (Linux, x86_64)

## Usage
There are two scripts to assist in the building process [build_deb.sh](build_deb.sh) for Debian/Ubuntu systems and [build_rpm.sh](build_rpm.sh) for RHEL/CentOS systems (untested).

I use this to build new consul packages with Jenkins `jenkins_build.sh` which only outputs Debian packages and is intended to be run on Debian-based systems with a working RVM installation that has the proper Ruby version installed (see [.ruby-version](.ruby-version)).

All scripts take the following environment variables:
* `CONSUL_VERSION` The version of consul to download and build. For the default see: [consul_version](consul_version)
* `BUILD_NUMBER` The build number of the package. Jenkins sets this automatically. For the default see: [build_number](build_number)
* `PACKAGE_DESCRIPTION` The description passed to FPM with `--description`. For the default see: [package_description](package_description)
* `PACKAGE_HOMEPAGE` The homepage passed to FPM with `--url`. For the default see: [package_homepage](package_homepage)
* `PACKAGE_MAINTAINER` The maintainer name passed to FPM with `--maintainer`. For the default see: [package_maintainer](package_maintainer)
* `PACKAGE_VENDOR` The vendor name passed to FPM with `--vendor`. For the default see: [package_vendor](package_vendor)
