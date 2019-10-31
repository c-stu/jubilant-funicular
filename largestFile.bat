:: Finds the largest file in a directory

for /f "delims=" %%A in ('dir /b /os') do set biggest=%%A
echo The biggest file is %biggest%
