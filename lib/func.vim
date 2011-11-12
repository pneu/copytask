let s:cpo_save = &cpo
set cpo&vim
set cpo-=<    " :help <SID>
let s:files={}

function! CopyTaskFiles()"{{{
  let s:files = <SID>new()
  call s:files.init()
endfunction"}}}

function! CopyTaskFiles_destructor()"{{{
  unlet s:files
endfunction"}}}

function! CopyTaskFiles_Add(path)"{{{
  call s:files.setpath(a:path)
endfunction"}}}

function! CopyTaskFiles_Get()"{{{
  return s:files.getpath()
endfunction"}}}

function! s:new()"{{{
  let obj = {}
  let obj.files = {}

  " constractor
  "" XXX: this func is not in use, reserved for future expansions
  function! obj.init() dict
  endfunction

  " association file with path
  function! obj.setpath(path) dict
    let name = <SID>path_to_varname(a:path)
    call extend(self.files, {name : {'path':a:path, 'enable':1}}, 'keep')
  endfunction
  function! obj.getpath() dict
    return self.files
  endfunction

  return obj
endfunction"}}}

function! s:path_to_varname(string)"{{{
  return substitute(a:string, '\W', '_', 'g')
endfunction"}}}

" restore option
let &cpo=s:cpo_save
unlet s:cpo_save

" vim:ts=2 sts=2 sw=2 et fdm=marker
