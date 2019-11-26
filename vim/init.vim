" basic settings
" set tabstop=4
" set softtabstop=4
" set shiftwidth=4
" set autoindent
"
" setting indent by file types
" indent 4
autocmd FileType php setl shiftwidth=4
autocmd FileType php setl tabstop=4
autocmd FileType php setl softtabstop=4 

" indent 2
autocmd FileType javascript setl shiftwidth=2
autocmd FileType javascript setl tabstop=2
autocmd FileType javascript setl softtabstop=2

" autocmd FileType php javascript setl expandtab

" tab & space visial
set list listchars=extends:>,precedes:<,tab:+\ ,trail:-

" plugins
call plug#begin('~/.config/nvim/plugged')
" brackets auto-pairs ============================================
    Plug 'jiangmiao/auto-pairs'
    Plug 'junegunn/vim-easy-align'

" emmet html css completion ==========================================
    Plug 'mattn/emmet-vim'

" status bar ==========================================================
	Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    " let g:airline#extensions#tabline#enabled = 1
    let g:airline_theme='simple'
    " let g:airline#extensions#tabline#left_sep = '|'
    " let g:airline#extensions#tabline#left_alt_sep = ' '
    " let g:airline#extensions#tabline#formatter = 'unique_tail'
    " set notermguicolors

" ncm 2 language completion framwork ============================================
"    " assuming you're using vim-plug: https://github.com/junegunn/vim-plug
"    Plug 'ncm2/ncm2'
"    Plug 'roxma/nvim-yarp'
"
"    " enable ncm2 for all buffers
"    autocmd BufEnter * call ncm2#enable_for_buffer()
"
"    " IMPORTANT: :help Ncm2PopupOpen for more information
"    set completeopt=noinsert,menuone,noselect
"
"    " NOTE: you need to install completion sources to get completions. Check
"    " our wiki page for a list of sources: https://github.com/ncm2/ncm2/wiki
"    Plug 'ncm2/ncm2-bufword'
"    Plug 'ncm2/ncm2-path'
"
"    " javascript completion
"    Plug 'ncm2/ncm2-tern',  {'do': 'npm install'}

" indent lines =========================================================
    " Plug 'Yggdroot/indentLine'
    " let g:indentLine_char = 'c'
    " let g:indentLine_char_list = ['.', '-', '-', '¦',]
    " let g:indentLine_color_term = 239

" code theme ==========================================================
    Plug 'connorholyday/vim-snazzy'

" current word underline =============================================
    Plug 'itchyny/vim-cursorword'

call plug#end()

colorscheme snazzy
