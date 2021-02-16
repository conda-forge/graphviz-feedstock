dot -c
if errorlevel 1 exit 1

dot -V
if errorlevel 1 exit 1

echo: | dot -v
if errorlevel 1 exit 1

fdp -V
if errorlevel 1 exit 1

neato -?
if errorlevel 1 exit 1

for %%t in (png, pdf, svg, tiff, jpeg) do (
    dot -T%%t -o sample.%%t sample.dot
    if errorlevel 1 exit 1
)
