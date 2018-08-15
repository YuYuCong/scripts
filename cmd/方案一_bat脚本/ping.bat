@echo off
::File                    :   .bat
::Programmer              :   YuCong windmillyucong@163.com
::Description             :   Windows批处理脚本用于ping命令
::Modification History	  :   ver1.0, 2017.09.16, William Yu
::                            ver1.1, 2017.09.17, William Yu add notes  
setlocal enabledelayedexpansion
set /a num=0
echo 测试开始时间 %date% %time:~0,2%:%time:~3,2%:%time:~6,2%
echo 测试开始时间 %date% %time:~0,2%:%time:~3,2%:%time:~6,2%>>log.txt  
for /f "delims=" %%a in (网站列表.txt) do (
	set /a num+=1 
	echo !num! %%a
	set /p = !num! %%a < nul  >> log.txt 
	ping %%a | find "平均" >> log.txt || echo 超时  >> log.txt
	echo %%a test over.
	echo -----------------------------------------
	)
echo 测试结束时间 %date% %time:~0,2%:%time:~3,2%:%time:~6,2%
echo 测试结束时间 %date% %time:~0,2%:%time:~3,2%:%time:~6,2%>>log.txt  
echo 全部执行结束,已记录进log.txt。
pause