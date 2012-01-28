#!/bin/sh
cd `dirname $0`
exec erl -pa $PWD/ebin \
     -pa /Library/WebServer/Documents/travelping/ChicagoBoss-0.6.10/ebin \
     -pa /Library/WebServer/Documents/travelping/ChicagoBoss-0.6.10/deps/*/ebin \
     -boss developing_app todomanager \
     -boot start_sasl -config boss -s reloader -s boss \
     -sname wildbill
