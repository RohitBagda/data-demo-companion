#!/bin/bash

set -e
cd "$(dirname -- "$0")"

cd ../kafka-1/connect-plugins

curl -s -L -O https://d1i4a15mxbxib1.cloudfront.net/api/plugins/confluentinc/kafka-connect-datagen/versions/0.6.4/confluentinc-kafka-connect-datagen-0.6.4.zip

unzip confluentinc-kafka-connect-datagen-0.6.4.zip
