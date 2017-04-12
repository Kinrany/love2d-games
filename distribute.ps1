$engineFolderName = "love-0.10.2-win32"
$engineFolderPath = Join-Path $PSScriptRoot $engineFolderName

$gameFolderName = "sketch1"
$gameFolderPath = Join-Path $PSScriptRoot $gameFolderName

$gameZipName = "$gameFolderName.love"
$gameZipPath = Join-Path $PSScriptRoot $gameZipName

$gameReleaseFolderName = "$gameFolderName-temporary"
$gameReleaseFolderPath = Join-Path $PSScriptRoot $gameReleaseFolderName

# convert game folder into .love file
#Get-ChildItem $gameFolderPath -Recurse | write-zip -OutputPath $gameZipPath -EntryPathRoot $gameFolderPath -IncludeEmptyDirectories
Add-Type -Assembly System.IO.Compression.FileSystem
$compressionLevel = [System.IO.Compression.CompressionLevel]::Fastest
[System.IO.Compression.ZipFile]::CreateFromDirectory($gameFolderPath, $gameZipPath, $compressionLevel, $false)

# create new empty directory
New-Item -Type "directory" -Path $gameReleaseFolderPath -Force
Remove-Item "$gameReleaseFolderPath/*" -Recurse

# add game .love file to the directory
Copy-Item $engineFolderPath "$gameReleaseFolderPath/$engineFolderName" -Recurse
Move-Item $gameZipPath $gameReleaseFolderPath

# create executable of some sort?
