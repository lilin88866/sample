@echo off
ipconfig >tem.txt
find /i "IP Address" tem.txt>temp.txt

for /f "tokens=15 delims= " %%i in (temp.txt) do (
	set Author_TRUNK=%%i
)
echo %Author_TRUNK%

REM for /f "tokens=15 delims= " %%i in (temp.txt) do (
	REM set Author_TRUNK=%%i
REM )
REM echo %Author_TRUNK%
echo ok