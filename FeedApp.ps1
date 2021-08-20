<#About the script:
  The script copies files from Data WareHouse resources to a temporary folder, rename copied file and move all files to the appropriate directory.

WinServer Config:
  For the automation the FeedApp process, I create new Task in Task Scheduler. 
  The feed should run daily, so i add new trigger with this configuration. 
    In Action -> Program/script i chose powershell.exe directory(Default dir C:\Windows\system32\WindowsPowershell).
    In Arguments i add FeedApp.ps1 dir.#>
    

#--- lista docelowych lokalizacji---
$dir_file1 = "dir"
$dir_file2 = "dir"
$dir_file3 = "dir"
$dir_file4 = "dir"

#--- ścieżka zasobu---
$dir = "dir_HD"


#---tablica lokalizacji---
$directory = @($dir_file3, $dir_file2, $dir_file1, $dir_file4, $dir_file4)


#---tablica plików---
$items = @($file3, $file4_pxt, $file4_txt, $file1, $file2)

#---przypisanie posortowanych po dacie modyfikacji nazw plików do tablicy plików---
for ($i=0; $i -lt 5; $i++) {
    $items[$i] = Get-ChildItem -Path $dir | Sort-Object CreationTime -Descending | Select-Object -ExpandProperty name | Select-Object -Skip $i | Select -First 1 
    }

#---skopiowanie plików z zasobu do tymczasowego katalogu---
for ($i=0; $i -lt 5; $i++) {
    Copy-Item ($dir + $items[$i]) -Destination C:\TempDir\
    }

#---zmiana nazwy plików z tymczasowego folderu (skrócenie nazwy do "_" z zachowaniem rozszerzenia)
Get-ChildItem 'C:\TempDir\' | Rename-Item -NewName { $_.BaseName.Split('_')[0] + $_.Extension }


#---nadpisanie tablicy plikow---
$items = @($file3,  $file2, $file1, $file4_pxt, $file4_txt)


#---przypisanie posortowanych alfabetycznie plikow do tablicy---
for ($i=0; $i -lt 5; $i++) {
    $items[$i] = Get-ChildItem -Path C:\TempDir\ | Sort-Object | Select-Object -ExpandProperty name | Select-Object -Skip $i | Select -First 1 
    }


#---przeniesienie plikow do docelowych katalogów z tymczasowego folderu---
for ($j=0; $j -lt 5; $j++) {
    Move-Item -Path ("C:\TempDir\" + $items[$j]) -Destination $directory[$j]
   } 


