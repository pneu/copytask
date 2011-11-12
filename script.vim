"" dairy copy script

" stack status"{{{
let s:save_sxq = &shellxquote
let s:save_ssl = &shellslash
set shellxquote=\" noshellslash
let s:save_cwd=getcwd()
cd %:p:h
"}}}

" provides other module"{{{
let s:basename=expand('%:p:h')
execute 'source ' . s:basename . '/etc/env.vim'
execute 'source ' . s:basename . '/etc/cmdopt.vim'
execute 'source ' . s:basename . '/etc/stdfunc.vim'
" acquire copy object manipulation
execute 'source ' . s:basename . '/lib/func.vim'
call CopyTaskFiles()
"}}}

" get copy src"{{{
let s:confs = split(glob('config/*.vim'))
for s:config in s:confs
  execute 'source ' . s:config
endfor
"}}}

" do copy
for s:file in keys(CopyTaskFiles_Get())
  let s:cmd = "copy " . copy_opt . ' ' .
      \ shellescape(CopyTaskFiles_Get()[s:file].path)
      \  ." ". shellescape(dest)
  call system(s:cmd)
endfor

" clean up and restore"{{{
call CopyTaskFiles_destructor()
execute 'cd ' . s:save_cwd
set shellxquote=s:save_sxq
if s:save_ssl == 0
  set noshellslash
else
  set shellslash
endif
"}}}

qall!

" vim:ts=2 sts=2 sw=2 et fdm=marker
