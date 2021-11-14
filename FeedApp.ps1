<# O skrypcie:
  Skrypt przenosi wybrane pliki z zasobu do folderu tymczasowego, zmienia ich nazwy i przenosi do folderu docelowego.

Konfiguracja środowiska windows:
  Do automatycznego uruchamiania się skryptu, stworzyłem nowe zadanie w Menadżerze zadań. 
  Proces powinień uruchamiać się codziennie, więc taki wyzwalacz ustawiłem. 
    W Akcjach -> Program/script wybrałem lokalizację powershell.exe (Domyślna lokalizacja C:\Windows\system32\WindowsPowershell).
    W Argumentach dodałem lokalizację skryptu FeedApp.ps1.#>
    

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


