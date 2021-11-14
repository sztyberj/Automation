#-- Test 1 ---

$file = 'Pełna ścieżka pliku, przykład blokady: ("_run_app") '

#---Jeżeli plik z blokadą istnieje, zmień jego nazwę (zdejmij blokadę)---
if (Test-Path -Path $file) {
     try {
         Rename-Item -Path $file -NewName 'New'		#Nowa nazwa pliku, na przykład: (run_app)
         
     }
     catch {
         throw $_.Exception.Message
     }
 }

 
#--Test 2 --
#--Sprawdzenie czy wybrane usługi na serwerze są uruchomione, jeżeli nie uruchamia je--
 
$services = 'List of services'
$services.Count = $max

for ($i=0; $i -lt $max; $i++) {
    Get-Service $service[$i] | WHERE {$_.Status -eq 'Stopped'} | Start-Service 
    }
