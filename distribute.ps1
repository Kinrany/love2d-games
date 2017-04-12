$engineFolderName = "love-0.10.2-win32"
$engineFolderPath = Join-Path $PSScriptRoot $engineFolderName

$gameFolderName = "sketch1"
$gameFolderPath = Join-Path $PSScriptRoot $gameFolderName

$gameZipName = "$gameFolderName.love"
$gameZipPath = Join-Path $PSScriptRoot $gameZipName

$gameReleaseFolderName = "$gameFolderName-temporary"
$gameReleaseFolderPath = Join-Path $PSScriptRoot $gameReleaseFolderName

$gameReleaseZipName = "$gameFolderName.zip"
$gameReleaseZipPath = Join-Path $PSScriptRoot $gameReleaseZipName

$updateExecutableName = "update-executable"
$updateExecutablePath = Join-Path $PSScriptRoot "$updateExecutableName.txt"

# convert game folder into .love file
#Get-ChildItem $gameFolderPath -Recurse | write-zip -OutputPath $gameZipPath -EntryPathRoot $gameFolderPath -IncludeEmptyDirectories
Add-Type -Assembly System.IO.Compression.FileSystem
$compressionLevel = [System.IO.Compression.CompressionLevel]::Fastest
[System.IO.Compression.ZipFile]::CreateFromDirectory($gameFolderPath, $gameZipPath, $compressionLevel, $false)

# create new empty directory
New-Item -Type "directory" -Path $gameReleaseFolderPath -Force
Remove-Item "$gameReleaseFolderPath/*" -Recurse

# add game .love file to the temp directory
Copy-Item $engineFolderPath "$gameReleaseFolderPath/$engineFolderName" -Recurse
Move-Item $gameZipPath $gameReleaseFolderPath

# add to the temp directory and run update-executable.bat
$updateExecutableBatPath = "$gameReleaseFolderPath/$updateExecutableName.bat"
Copy-Item $updateExecutablePath $updateExecutableBatPath
. $updateExecutableBatPath

# create a .zip archive of the temp directory
$compressionLevel = [System.IO.Compression.CompressionLevel]::Optimal
# TODO: preserve symlinks
[System.IO.Compression.ZipFile]::CreateFromDirectory($gameReleaseFolderPath, $gameReleaseZipPath, $compressionLevel, $false)

# TODO: remove temp directory
