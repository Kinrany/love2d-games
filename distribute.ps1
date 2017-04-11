$name = "sketch1"
$dotlove = "$name.love"
$tempdir = "$name-distrib"
$engine = "love-0.10.2-win32"

# convert game folder into .love file
Get-ChildItem $name -Recurse | write-zip -OutputPath $dotlove -EntryPathRoot $name -IncludeEmptyDirectories

# create new empty directory
new-item -Type "directory" -Name $tempdir -Force
remove-item "$tempdir/*" -Recurse

# add game engine and .love file to the directory
copy-item $engine "$tempdir/$engine" -Recurse
move-item $dotlove $tempdir

# create executable of some sort?
