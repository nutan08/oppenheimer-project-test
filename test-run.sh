#!/usr/bin/env bash

if [ -d output ]; then
  rm -rf output
fi

robot --outputdir ./output \
  ./tests/userstory1.robot \
  ./tests/userstory2.robot \
  ./tests/userstory3.robot \
  ./tests/userstory4.robot \
  ./tests/tax_relief_computation_boundry_test.robot




