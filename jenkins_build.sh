#!/usr/bin/env bash
set -x
rm -f consul*.{deb,rpm}

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

/usr/bin/which rvm
if [ $? -eq 0 ]; then
  [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
  [[ -s '/etc/profile.d/rvm.sh' ]] && source '/etc/profile.d/rvm.sh'

  rvm use $(<.ruby-version)@$(<.ruby-gemset) --create
  source ${rvm_path}/environments/$(<.ruby-version)@$(<.ruby-gemset)
fi

gem install bundler --no-ri --no-rdoc
set -e # exit if any errors
bundle install

get_consul
extract_consul
build_consul_deb
