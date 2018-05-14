#!/bin/bash
! find lib -type f -printf '%f\n' |  grep -Evx '([a-z]|[0-9]|_)+\.dart'