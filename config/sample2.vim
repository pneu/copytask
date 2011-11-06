"" build filename
let s:timeout = 3     " sec
let s:found=0

let s:date=strftime('%Y%m%d')[2:]
let s:time=localtime()
let s:expire=s:time + s:timeout
while s:expire>=localtime()
  " my_path is pre-defined in etc/env.vim
  let s:file = my_path . 'myfile' . s:date . '.xls'
  if filereadable(s:file) == 1
    let s:found=1
    break
  endif
  let s:date=str2nr(s:date) - 1
endwhile

if s:found
  call add(files, s:file)
endif
