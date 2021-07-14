#lista lokalizacji
$dir_rachunki = "File dir"
$dir_powiazania = "File dir"
$dir_klienci = "File dir"
$dir_transakcje = "File dir"

$dir_HD = "Mapped DatawareHouse resource"


#tablica lokalizacji
$directory = @($dir_klienci, $dir_transakcje, $dir_transakcje, $dir_rachunki, $dir_powiazania)


#tablica plików
$items = @($klienci, $trans_pxt, $trans_txt, $rachunki, $powiazania)

for ($i=0; $i -lt 5; $i++) {
    $items[$i] = Get-ChildItem -Path $dir_HD | Sort-Object CreationTime -Descending | Select-Object -ExpandProperty name | Select-Object -Skip $i | Select -First 1 
    }

$items

for ($i=0; $i -lt 5; $i++) {
    Copy-Item ($dir_HD + $items[$i]) -Destination C:\TempFolder\
    }

Get-ChildItem 'C:\TempFolder\' | Rename-Item -NewName { $_.BaseName.Split('_')[0] + $_.Extension }

for ($i=0; $i -lt 5; $i++) {
    $items[$i] = Get-ChildItem -Path "C:\TempFolder\" | Sort-Object CreationTime -Descending | Select-Object -ExpandProperty name | Select-Object -Skip $i | Select -First 1 
    }



for ($j=0; $j -lt 5; $j++) {
Move-Item -Path ("C:\TempFolder\" + $items[$j]) -Destination $directory[$j]
} 


