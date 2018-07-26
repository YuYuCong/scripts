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