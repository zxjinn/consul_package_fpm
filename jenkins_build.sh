#!/usr/bin/env bash
set -x
rm consul_*-*.deb

source functions.sh

# Get Pre-reqs in place

## if Debian, query for then install required packages
if [ -n $(which /usr/bin/apt-get) ]; then
  # gcc, package name- 'gcc'
  if [ -z $(which gcc) ]; then
    /usr/bin/apt-get install -y gcc
  fi
else
  echo "OS not tested, pull requests welcomed"
  exit 1
fi

/usr/local/rvm/bin/rvm use $(<.ruby-version)@$(<.ruby-gemset) --create
source /usr/local/rvm/environments/$(<.ruby-version)@$(<.ruby-gemset)
gem install bundler --no-ri --no-rdoc
set -e # exit if any errors
bundle install

get_consul
extract_consul
build_consul_deb
