dot -c
if errorlevel 1 exit 1

dot -V
if errorlevel 1 exit 1

dot -v < NUL
if errorlevel 1 exit 1

fdp -V
if errorlevel 1 exit 1

sfdp -V
if errorlevel 1 exit 1

neato -?
if errorlevel 1 exit 1

for %%t in (png, svg, tiff, jpeg) do (
    dot -T%%t -o sample.%%t sample.dot
    if errorlevel 1 exit 1
)
