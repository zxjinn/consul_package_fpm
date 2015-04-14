#
# No shebang header, not intended to be run directly
# Intentionally not marked as executable
#
# Set global variables
#
## If the environment variable is set use that,
## otherwise use the default version
if [ $CONSUL_VERSION ]; then
  BUILD_CONSUL_VERSION=${CONSUL_VERSION}
else
  BUILD_CONSUL_VERSION=$(<consul_version)
fi
BUILD_CONSUL_BIN_NAME="consul/usr/bin/consul"

function get_consul()
{
  BUILD_CONSUL_ZIP_NAME="${BUILD_CONSUL_VERSION}_linux_amd64.zip"
  /usr/bin/wget --continue https://dl.bintray.com/mitchellh/consul/${BUILD_CONSUL_ZIP_NAME} -O ${BUILD_CONSUL_ZIP_NAME}
}

function extract_consul()
{
  # function requires that get_consul function be ran beforehand at least one time
  BUILD_CONSUL_ZIP_NAME="${BUILD_CONSUL_VERSION}_linux_amd64.zip"
  /bin/mkdir -p $(/usr/bin/dirname ${BUILD_CONSUL_BIN_NAME})
  if [ -s ${BUILD_CONSUL_ZIP_NAME} ]; then
    # This seemingly only extracts one file, which the consul zip currently has,
    # the process will break if more than one file is in the zipfile
    /bin/gunzip --decompress --stdout ${BUILD_CONSUL_ZIP_NAME} > ${BUILD_CONSUL_BIN_NAME}
    /bin/chmod +x ${BUILD_CONSUL_BIN_NAME}
  fi
}

function build_consul_deb()
{
  build_consul deb
}

function build_consul_rpm()
{
  build_consul rpm
}

function build_consul()
{
  # requires that extract_consul function be run beforehand at least one time
  if [ $1 ]; then
    BUILD_PACKAGE_TYPE=${1}
  else
    echo "Package type not specified"
    exit 1
  fi

  if [ ${BUILD_NUMBER} ]; then
    BUILD_PACKAGE_BUILD_NUMBER=${BUILD_NUMBER}
  else
    BUILD_PACKAGE_BUILD_NUMBER=$(<build_number)
  fi

  if [ ${PACKAGE_DESCRIPTION} ]; then
    BUILD_PACKAGE_DESCRIPTION=${PACKAGE_DESCRIPTION}
  else
    BUILD_PACKAGE_DESCRIPTION=$(<package_description)
  fi

  if [ ${PACKAGE_HOMEPAGE} ]; then
    BUILD_PACKAGE_HOMEPAGE=${PACKAGE_HOMEPAGE}
  else
    BUILD_PACKAGE_HOMEPAGE=$(<package_homepage)
  fi

  if [ ${PACKAGE_MAINTAINER} ]; then
    BUILD_PACKAGE_MAINTAINER=${PACKAGE_MAINTAINER}
  else
    BUILD_PACKAGE_MAINTAINER=$(<package_maintainer)
  fi

  if [ ${PACKAGE_VENDOR} ]; then
    BUILD_PACKAGE_VENDOR=${PACKAGE_VENDOR}
  else
    BUILD_PACKAGE_VENDOR=$(<package_vendor)
  fi

  BUILD_VERSION="${BUILD_CONSUL_VERSION}-${BUILD_PACKAGE_BUILD_NUMBER}"

  if [ -x ${BUILD_CONSUL_BIN_NAME} ]; then
    fpm -s "dir" -t "${BUILD_PACKAGE_TYPE}" --name "consul" --version "${BUILD_VERSION}" --architecture "x86_64" --maintainer "${BUILD_PACKAGE_MAINTAINER}" --vendor "${BUILD_PACKAGE_VENDOR}" --description "${BUILD_PACKAGE_DESCRIPTION}" --url "${BUILD_PACKAGE_HOMEPAGE}" consul/
  fi
}
