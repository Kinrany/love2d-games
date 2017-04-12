setlocal
set name=sketch1
copy /b "love-0.10.2-win32\love.exe"+%name%.love love-0.10.2-win32\%name%.exe
mklink %name%.exe love-0.10.2-win32\%name%.exe
