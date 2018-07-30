function! Yamlpath()
  let var = system('yaml-path -line ' . line('.') . ' -col ' . col('.'), join(getline(1,'$') , "\n"))
  let clean = substitute(var, "\n", "", "")
  echom clean
endfunction

au FileType yaml :autocmd CursorMoved * call Yamlpath()
