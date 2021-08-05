#----SKRYPT ZASILAJACY ŚRODOWISKO TESTOWE PLIKAMI Z HURTOWNI DANCYH----

#--- lista docelowych lokalizacji---
$dir_rachunki = "dir"
$dir_powiazania = "dir"
$dir_klienci = "dir"
$dir_transakcje = "dir"

#--- ścieżka zasobu Hurtowni---
$dir_amlHD = "dir_HD"


#---tablica lokalizacji---
$directory = @($dir_klienci, $dir_powiazania, $dir_rachunki, $dir_transakcje, $dir_transakcje)


#---tablica plików---
$items = @($klienci, $trans_pxt, $trans_txt, $rachunki, $powiazania)

#---przypisanie posortowanych po dacie modyfikacji nazw plików do tablicy plików---
for ($i=0; $i -lt 5; $i++) {
    $items[$i] = Get-ChildItem -Path $dir_amlHD | Sort-Object CreationTime -Descending | Select-Object -ExpandProperty name | Select-Object -Skip $i | Select -First 1 
    }

#---skopiowanie plików z zasobu HD do tymczasowego katalogu---
for ($i=0; $i -lt 5; $i++) {
    Copy-Item ($dir_amlHD + $items[$i]) -Destination C:\TempDir\
    }

#---zmiana nazwy plików z tymczasowego folderu (skrócenie nazwy do "_" z zachowaniem rozszerzenia)
Get-ChildItem 'C:\TempDir\' | Rename-Item -NewName { $_.BaseName.Split('_')[0] + $_.Extension }


#---nadpisanie tablicy plikow---
$items = @($klienci,  $powiazania, $rachunki, $trans_pxt, $trans_txt)


#---przypisanie posortowanych alfabetycznie plikow do tablicy---
for ($i=0; $i -lt 5; $i++) {
    $items[$i] = Get-ChildItem -Path C:\TempDir\ | Sort-Object | Select-Object -ExpandProperty name | Select-Object -Skip $i | Select -First 1 
    }


#---przeniesienie plikow do docelowych katalogów z tymczasowego folderu---
for ($j=0; $j -lt 5; $j++) {
    Move-Item -Path ("C:\TempDir\" + $items[$j]) -Destination $directory[$j]
   } 


