#Loop through network and run nbtstat on each host
$i = 0
$outfile = read-host what is the folder you want to put the results into? example: C:\Users\user\Documents
$IP_Find = read-host what are the first 3 octects of the network range you want to scan? example: 192.168.1
while ($i -lt 255)
    {
        $IP = "$IP_Find.$i"
        $i = $i + 1
        $i
        $stat = nbtstat -a $IP
        add-content -Value $IP -Path "$outfile\file1.txt"
        Add-Content -Value $stat -Path "$outfile\file1.txt"
    }


#Clean up the results file for just: IP,Hostname, and MAC Address
get-content "$outfile\file1.txt" | select-string -pattern 'Host not found.' -notmatch | select-string -pattern 'Node' -notmatch | select-string -pattern 'Connection' -notmatch | select-string -pattern 'NetBIOS' -notmatch | select-string -pattern 'Adapter' -notmatch | select-string -pattern 'Ethernet' -notmatch | Select-String -Pattern 'Wi-Fi' -NotMatch | Where { $_ } | Set-Content "$outfile\file2.txt"
get-content "$outfile\file2.txt" | select-string -Pattern 'Name' -notmatch | select-string -Pattern '<20>' -notmatch | select-string -Pattern '--------' -notmatch |Set-Content "$outfile\final.txt"