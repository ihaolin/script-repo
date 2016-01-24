#!/usr/bin/env bash

curl -L -O https://download.elastic.co/elasticsearch/elasticsearch/elasticsearch-1.5.2.tar.gz

tar -xvf elasticsearch-1.5.2.tar.gz

mv elasticsearch-1.5.2 elasticsearch

cd elasticsearch && ./bin/elasticsearch