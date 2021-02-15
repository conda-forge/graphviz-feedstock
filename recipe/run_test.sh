#!/bin/bash
set -ex

dot -c
dot -V
echo | dot -v
fdp -V
neato -?

dot -Tpng -o sample.png sample.dot
dot -Tpdf -o sample.pdf sample.dot
dot -Tsvg -o sample.svg sample.dot
