" Toggle 'default' terminal
nnoremap <C-\> :call ChooseTerm("term-slider", 1)<CR>
" Start terminal in current pane
"nnoremap <C-'> :call ChooseTerm("term-pane", 0)<CR>

function! ChooseTerm(termname, slider)
	let pane = bufwinnr(a:termname)
	let buf = bufexists(a:termname)
	if pane > 0
		" pane is visible
		if a:slider > 0
			:exe pane . "wincmd c"
		else
			:exe "e #"
		endif
	elseif buf > 0
		" buffer is not in pane
		if a:slider
			:exe "botright 15split"
		endif
		:exe "buffer " . a:termname
        :resize 15
        :startinsert
	else
		" buffer is not loaded, create
		if a:slider
			:exe "botright 15split"
            :resize 15
		endif
		:terminal
        :startinsert
		:exe "f " a:termname
	endif
endfunction
