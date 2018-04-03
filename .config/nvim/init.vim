" Frank Bojen's .vimrc

" Plugins {{{
" =======
call plug#begin('~/.local/share/nvim/plugged')


set tabstop=4
set shiftwidth=4
set softtabstop=0 noexpandtab


" AutoComplete
Plug 'autozimu/LanguageClient-neovim', { 'branch': 'next', 'do': 'bash install.sh' }
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
let g:deoplete#enable_at_startup = 1

" fzf
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Theme
Plug 'dracula/vim', { 'as': 'dracula' }

" Syntax Highlighting
Plug 'sheerun/vim-polyglot'

Plug 'w0rp/ale'

Plug 'justinmk/vim-sneak'

Plug 'tpope/vim-eunuch'

" Easy navigation between vim splits and tmux panes.
Plug 'christoomey/vim-tmux-navigator'
" Functions that interact with tmux.
Plug 'tpope/vim-tbone'
" Generate statuslines for tmux.
Plug 'edkolev/tmuxline.vim'
" Focus events & clipboard
Plug 'roxma/vim-tmux-clipboard'
Plug 'tmux-plugins/vim-tmux-focus-events'

" Statusline
" Plug 'itchyny/lightline.vim'
" Plug 'cocopon/lightline-hybrid.vim'
Plug 'vim-airline/vim-airline'

" Surroundings ("", '', {}, etc.).
Plug 'tpope/vim-surround'
" Auto-adds 'end' where appropriate.
Plug 'tpope/vim-endwise'

call plug#end()
" }}}

syntax on
color dracula

" Language Server {{{
" ===============
let g:LanguageClient_autoStart = 1
let g:LanguageClient_serverCommands = {}

if executable('cquery')
    let g:LanguageClient_serverCommands.c = ['cquery', '--language-server']
    let g:LanguageClient_serverCommands.cpp = ['cquery', '--language-server']
endif
" }}}

" Deoplete {{{
" ========

" Disable delay
let g:neocomplete#auto_complete_delay = 0

" Use smartcase
let g:neocomplete#enable_smart_case = 1

" Use tabs for completion.
inoremap <silent><expr> <TAB>
            \ pumvisible() ? "\<C-n>" :
            \ <SID>check_back_space() ? "\<TAB>" :
            \ deoplete#mappings#manual_complete()
function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction
" }}}

" Ale {{{
" ===
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'

let g:ale_linters = {
\   'asm': [],
\	'c': [],
\}

let g:ale_pattern_options = {
\   '.*\.tex\.njk$': { 'ale_enabled': 0 },
\}

nmap <C-n> <Plug>(ale_next_wrap)
" }}}

" Mouse {{{
" =====
set mouse=a
" }}}

" Spelling {{{
" ========
set spelllang=en_gb
" }}}

" fzf {{{
" ===
nnoremap <c-p> :Files<CR>
nnoremap <leader>pf :Files<CR>
nnoremap <leader>pg :GFiles<CR>
nnoremap <leader>pc :Commits<CR>
nnoremap <leader>pb :Buffers<CR>
nnoremap <leader>pt :Tags<CR>

" Mapping selecting mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)
" }}}

" UI & Visual Cues {{{
" ================
set ruler           " Show ruler.
set showcmd         " Show incomplete commands.
set nocursorline    " Highlight the current line.
set lazyredraw      " Lazy redraw.
set number          " Line Numbers
set report=0        " Display messages for changes (ie. yank, delete, etc.)
set showmatch       " Show matching brackets.
set mat=5           " Matching bracket duration.
set visualbell      " Shut up, Vim.
set laststatus=2    " Always show the status line.
"set relativenumber  " Use Relative Line Numbers.
set noshowmode      " Don't display '-- INSERT --', handled by statusline.
let &colorcolumn="100,".join(range(140, 1000, 40), ",") " Colour 40 columns after column 80.
" hi LineNr       term=bold cterm=bold ctermfg=2 ctermbg=1 guifg=Grey guibg=Grey
let g:airline_powerline_fonts = 1

" Display the tab characters and end of line characters.
set list
set listchars=tab:▸\ ,eol:¬
" }}}
