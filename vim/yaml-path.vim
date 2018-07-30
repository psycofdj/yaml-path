function! Yamlpath()
  let var = system('yaml-path -line ' . line('.') . ' -col ' . col('.'), join(getline(1,'$') , "\n"))
  echom var
endfunction

au FileType yaml :autocmd CursorMoved * call Yamlpath()
