#!/usr/bin/env sh

theme=$(darkman get)

if [ "${theme}" = "light" ]; then
  wmenu-run -N ffffff -n 000000 -S 9f9f9f -s 000000
else
  wmenu-run -N 000000 -n ffffff -S 646464 -s ffffff
fi
