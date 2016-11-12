function! Save()
  call VimuxRunCommand('git add '.@%.' ; git commit -S -m "Auto-save: $(date)" ')
endfunction

function! Push()
  call VimuxRunCommand('git push')
endfunction

function! Make()
  call VimuxRunCommand('make -j`nproc`')
endfunction

autocmd! BufWritePost *.js :call Make()
autocmd! BufWritePost * :call Save()
autocmd! VimLeave * :call Push()

set tw=80

set path+=**
set wildmenu
