#!/bin/bash
set -ex

# the package ships the plugin configuration; only cross-compiled builds register them at
# install time (post-link script)
test -f "${PREFIX}/lib/graphviz/config8" || dot -c
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
