function! Yamlpath()
  let var = system('yaml-path -line ' . line('.') . ' -col ' . string(col('.')-1), join(getline(1,'$') , "\n"))
  let clean = substitute(var, "\n", "", "")
  redraw!
  echom clean
endfunction

au FileType yaml :autocmd CursorMoved * call Yamlpath()
