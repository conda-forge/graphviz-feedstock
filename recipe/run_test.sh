#!/bin/bash
set -ex

# the package ships the plugin configuration (dot -c at build time)
test -f "${PREFIX}/lib/graphviz/config8"
dot -V
dot -v < /dev/null
fdp -V
sfdp -V
neato -?

dot -T? || true

dot -Tpng -o sample.png sample.dot
dot -Tpdf -o sample.pdf sample.dot
dot -Tsvg -o sample.svg sample.dot
dot -Ttiff -o sample.tiff sample.dot
dot -Tjpeg -o sample.jpeg sample.dot
sfdp -Tpdf -o sample.pdf sample.dot
