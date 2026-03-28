#!/usr/bin/env bash
docker build --build-arg VERSION=4.2.2 --platform linux/amd64 -t ghcr.io/nevrending/lavalink:4.2.2 .
