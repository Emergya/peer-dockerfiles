#!/bin/bash

echo "Building Python image..."
docker build -t peer/python:2.7.10 python/
