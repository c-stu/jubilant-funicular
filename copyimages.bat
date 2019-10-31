:: Script not written by me

@ECHO OFF
@REM This is my custom copy batch file for pictures.
@REM It will create a new folder w/todays date in the My Pictures folder.
@REM NOTE! always do a trial run first! you can run the batch file from any folder or path
@REM No errorchecking is in place, be sure to type in the paths as D: or J: if the camera
@REM drive is the D or J. case sensitive too. you can add these yourself if you’d like
@REM Setting the global varibles
@REM userfolder is basically which drive your my documents folder is located in
@REM —default should be fine for most people w/normal xp installs
@REM cameraDrive is the drive for your camera
@REM type is the type of files your camera saves your images as, most are jpg
@REM (used to find folder of vids on camera)

ECHO ________________

SET userfolder=C:
SET type=jpg
SET /P cameradrive=Enter Camera Drive Letter (ie D:) and hit Enter:

@REM Finds what your userid is for user running script and then sets it as a user variable
for /f “tokens=3 delims=\” %%i in (“%USERPROFILE%”) DO (set user=%%i)

@REM parses month, day, and year into mm , dd, yyyy formats to create folders off of!

FOR /F “TOKENS=1* DELIMS= ” %%A IN (‘DATE/T’) DO SET CDATE=%%B
FOR /F “TOKENS=1,2 eol=/ DELIMS=/ ” %%A IN (‘DATE/T’) DO SET mm=%%B
FOR /F “TOKENS=1,2 DELIMS=/ eol=/” %%A IN (‘echo %CDATE%’) DO SET dd=%%B
FOR /F “TOKENS=2,3 DELIMS=/ ” %%A IN (‘echo %CDATE%’) DO SET yyyy=%%B
SET date=%mm%%dd%%yyyy%

@REM Creating a folder in the ‘my pictures’ folder w/the [MM-DD-YYYY] format
@REM Also changes directory to the new folder
@REM –I use a year\date hierarchy to sort photos, so for example:
@REM — [2006]\[12-25-2006]\dsc004.jpg, etc; keeps it easy to find via date

%userfolder%
cd\
cd “Documents and Settings\%user%\My Documents\My Pictures”
mkdir “[%yyyy%]”
cd “[%yyyy%]
mkdir “[%mm%-%dd%-%yyyy%]”
cd “[%mm%-%dd%-%yyyy%]”

@REM Finds full path of where photos are on the camera
@REM and also copies them to the new folder (limited to 2 subfolders,
@REM you’ll need to add a third for statement if your images are nested deeper and change token to 4)

%cameraDrive%
FOR /F “TOKENS=2 DELIMS=\” %%A IN (‘dir /b /s *.%type%’) DO SET p1=%%A
FOR /F “TOKENS=3 DELIMS=\” %%A IN (‘dir /b /s *.%type%’) DO SET p2=%%A
CD “%p1%\%p2%”
COPY *.* %userfolder%

@REM Delete the originals prompt and then actions

SET /P delete=Delete Original Photos from Camera (y/n)?

IF /I “%delete%”==”y” GOTO delY
IF /I “%delete%”==”n” GOTO delN

:delY
%cameraDrive%
del /q *.*
explorer.exe “%userfolder%\Documents and Settings\%user%\My Documents\My Pictures\[%yyyy%]\[%mm%-%dd%-%yyyy%]”

:delN
explorer.exe “%userfolder%\Documents and Settings\%user%\My Documents\My Pictures\[%yyyy%]\[%mm%-%dd%-%yyyy%]
