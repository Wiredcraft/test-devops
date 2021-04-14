#!/bin/bash

`docker stop oldVersionApplication`
`docker pull newVersionApplicationImage`
`
docker run -p 8008:8008 -d newVersionApplication`
