:: Go to each directory and rename the files. deleting ones that are not needed. (called from another script)

SET FIRST_ARG=%~1
SET WORKSPACE_DIR=
SET DIRECTORY=%WORKSPACE_DIR%<insert path>\%FIRST_ARG%
pushd %DIRECTORY%
for /f %%i in ('dir /b/a-d/od/t:c') do set LAST=%%i
ren %Last% %FIRST_ARG%.har
for %%i in (*) do if not %%i == %FIRST_ARG%.har del %%i
popd
