foreach($file in Get-ChildItem .) {$(Get-Item $file.Fullname).lastwritetime=$(Get-Date)}
