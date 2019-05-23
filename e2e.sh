#!/bin/bash

pkill qqq

(cd qqq-app && rails s &)
open http://localhost:3600

cd qqq-gem 
qqq tail &
TAIL_PID=$$

qqq payload &
PAYLOAD_PID=$$

qqq mark
qqq echo "hello there"

pkill qqq
pkill "qqq tail"
pkill "qqq payload"
rake install > /dev/null