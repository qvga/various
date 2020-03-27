#!/bin/bash

LATEST_JORVERSION=$(curl -fsSLI -o /dev/null -w %{url_effective} https://github.com/input-output-hk/jormungandr/releases/latest | sed 's#.*tag/##g')
INSTALLED_JORVERSION="v$(./jormungandr --version 2>> /dev/null | sed 's/[[:alpha:]|(|[:space:]]//g' | awk -F- '{print $1}')"
ARCH=$(uname -m)
OS=$(uname -s | awk '{print tolower($0)}')

echo "Latest version is $LATEST_JORVERSION, your version is $INSTALLED_JORVERSION"

JOR_ARCHIVE="jormungandr-$LATEST_JORVERSION-$ARCH-unknown-$OS-gnu-generic.tar.gz"
URL="https://github.com/input-output-hk/jormungandr/releases/download/$LATEST_JORVERSION/$JOR_ARCHIVE"

if [ "$LATEST_JORVERSION" != "$INSTALLED_JORVERSION" ]; then
      echo "Downloading and extracting $JOR_ARCHIVE"
      wget "$URL" -qO- | tar zxv
fi

echo "Installed version after running this script: $(./jormungandr --full-version)"

rm createAddress.sh createStakePool.sh delegate-account.sh send-certificate.sh send-money.sh 2>> /dev/null
wget "https://raw.githubusercontent.com/input-output-hk/jormungandr-qa/master/scripts/createAddress.sh" -q
wget "https://raw.githubusercontent.com/input-output-hk/jormungandr-qa/master/scripts/createStakePool.sh" -q
wget "https://raw.githubusercontent.com/input-output-hk/jormungandr-qa/master/scripts/delegate-account.sh" -q
wget "https://raw.githubusercontent.com/input-output-hk/jormungandr-qa/master/scripts/send-certificate.sh" -q
wget "https://raw.githubusercontent.com/input-output-hk/jormungandr-qa/master/scripts/send-money.sh" -q
chmod +x createAddress.sh createStakePool.sh delegate-account.sh send-certificate.sh send-money.sh
