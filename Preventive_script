#-- Test 1 ---
#Checking file name, 
$file = 'File dir with blockade example ("_run_app") '

#---If file with blockade exist, change his name---
if (Test-Path -Path $file) {
     try {
         Rename-Item -Path $file -NewName 'New'		#New name without blockade, example (run_app)
         
     }
     catch {
         throw $_.Exception.Message
     }
 }

 
#--Test 2 --
#--Checking services on server, if are stopped, run--
 
$services = 'List of services'
$services.Count = $max

for ($i=0; $i -lt $max; $i++) {
    Get-Service $service[$i] | WHERE {$_.Status -eq 'Stopped'} | Start-Service 
    }
