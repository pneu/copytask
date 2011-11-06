"" dairy copy script

" check function available"{{{
if !exists("*strftime")
  finish
endif
"}}}

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
let files=[]    " synced files
"}}}

" read filename downloaded"{{{
let s:confs = split(glob('config/*.vim'))
for s:config in s:confs
  execute 'source ' . s:config
endfor
"}}}

" do copy
for file in files
  let s:cmd = "copy ".copy_opt. ' ' . shellescape(file) ." ". shellescape(dest)
  call system(s:cmd)
endfor


" clean up and restore"{{{
unlet files

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
