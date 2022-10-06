#!/usr/bin/env bash

if [ -d output-UI ]; then
  rm -rf output-UI
fi

robot --outputdir ./output-UI \
  ./tests/userstory3_UI.robot \
  ./tests/userstory5_UI.robot \
  



