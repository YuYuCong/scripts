---
layout: post
title: "scripts"
description: "脚本编程"
categories: [scripts]
tags: [code,linux,scripts]
redirect_from:
  - /2018/02/12/
---

> 脚本编程

* Kramdown table of contents
{:toc .toc}
# 脚本

Created 2017.09.18 by William Yu; Last modified: 2018.07.26-V1.0.2

Contact :[windmillyucong@163.com](mailto:windmillyucong@163.com)

Copyleft ! 2018 William Yu. Some Rights Reserved.

---

## 脚本：ping全国高校教育网

##### 解决方案一：bat批处理脚本

```bat
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
```

##### 解决方案二：powershell脚本

```powershell
#File                    :   .ps1
#Programmer              :   YuCong windmillyucong@163.com
#Description             :   Windows PowerShell脚本用于ping命令
#Modification History    :   ver1.0, 2017.09.17, William Yu
#                            ver1.1, 2017.09.18, William Yu add notes  
$ComPList = Get-Content "网站列表.txt"
"开始时间 $(Get-Date)" >> log.txt
function Ping_Test
{
    PROCESS
    {
      $ping = $false
      $results = Get-WmiObject -query "SELECT * FROM Win32_PingStatus WHERE Address = '$_'"
      $RT = $results.ResponseTime
      $TTL = $results.ResponseTimeToLive
      foreach ($result in $results)
      {
        if ($results.StatusCode -eq 0)
        {
            if ($TTL -ge 98 -and $TTL -le 128)
                {Write-Host "$_ 测试响应时间 $RT ms" -ForegroundColor Green
				"$_ 测试响应时间 $RT ms" >> log.txt}
             else
                {Write-Host "$_ 测试响应时间 $RT ms" -ForegroundColor Blue
				"$_ 测试响应时间 $RT ms" >> log.txt}
        }
        else
        {
          Write-Host "$_ 超时!"-ForegroundColor Red
		  "$_ 测试响应时间 超时 ms" >> log.txt
        }
      }
    }
}
foreach ($Server in $ComPList)
{
  $Server | Ping_Test
}
"结束时间 $(Get-Date)" >> log.txt
Write-Host "全部执行结束,已记录进log.txt。" -ForegroundColor White
Pause
```



## Contact

Have anything in mind that you think is awesome and would fit in this blog? Feel free to send a pull request.

-----



## License

[![CC0](http://i.creativecommons.org/p/zero/1.0/88x31.png)](http://creativecommons.org/publicdomain/zero/1.0/)

