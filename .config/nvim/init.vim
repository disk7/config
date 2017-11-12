"----------------------------------------------------
" Dein
"----------------------------------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
" プラグインが実際にインストールされるディレクトリ
let s:dein_dir = expand('~/.cache/dein')
" dein.vim 本体
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

" Required:
" dein.vim がなければ github から落としてくる
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

" Required:
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  "call dein#add('neovim/python-client')
  "call dein#add('Shougo/dein.vim')
  "call dein#add('critiqjo/lldb.nvim')

  " プラグインリストを収めた TOML ファイル置き場
  let s:rc_dir = expand('~/.config/nvim/')

  " TOML を読み込み、キャッシュしておく
  call dein#load_toml(s:rc_dir . '/plugins.toml', {'lazy': 0})
  call dein#load_toml(s:rc_dir . '/lazy.toml', {'lazy': 1})

  " Required:
  call dein#end()
  call dein#save_state()
endif

" Required:
filetype plugin indent on
syntax enable
let g:python_host_prog = '/usr/bin/python'
let g:python3_host_prog = '/usr/local/bin/python3'

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

"----------------------------------------------------
" 基本設定
"----------------------------------------------------
" 文字コード
set encoding=utf-8
" 書込文字コード
set fileencoding=utf-8
" 読込文字コード
set fileencodings=utf-8,euc-jp,shift_jis
" 改行コードの自動認識
set fileformats=unix,dos,mac

" 検索
set hlsearch
set incsearch
set ignorecase
set smartcase
set wrapscan
set history=100

" 表示
set title
syntax enable
set background=dark
colorscheme mycolor
"colorscheme hybrid

" コマンドライン
set laststatus=2
set cmdheight=2
set showcmd
set statusline=%f%m%=%l,%c\ %{'['.(&fenc!=''?&fenc:&enc).']\ ['.&fileformat.']'}
set wildmenu
set wildmode=list:longest

" インデント/タブ/ラップ
set autoindent
set shiftwidth=4
set expandtab
set tabstop=4
set softtabstop=4
augroup vimrc
  autocmd! FileType html       setlocal shiftwidth=2 tabstop=2 softtabstop=2
  autocmd! FileType gohtmltmpl setlocal shiftwidth=2 tabstop=2 softtabstop=2
  autocmd! FileType smarty     setlocal shiftwidth=2 tabstop=2 softtabstop=2
  autocmd! FileType css        setlocal shiftwidth=2 tabstop=2 softtabstop=2
  autocmd! FileType javascript setlocal shiftwidth=2 tabstop=2 softtabstop=2
augroup END
set backspace=2

" マウス有効
set mouse=a

" Copy&Past
set clipboard+=unnamedplus
"" For Neovim Bug (* Rectangle Past is not working.)
"map p <Plug>(miniyank-autoput)
"map P <Plug>(miniyank-autoPut)

" -(Misc)-

" 全角スペースの表示
highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=darkgray
match ZenkakuSpace /　/
" 改行で自動的にコメント挿入されるのを防ぐ
autocmd FileType * setlocal formatoptions-=ro
" □とか○の文字があってもカーソル位置がずれないようにする
if exists('&ambiwidth')
  set ambiwidth=double
endif
" ビープ音を鳴らさない
set vb t_vb=
" オムニ補完
set completeopt=menuone

" タブ文字の先頭にカーソルを表示
set list lcs=tab:\ \ 
"" -> Note the extra space after the second \


"----------------------------------------------------
" Leader
"----------------------------------------------------
let mapleader = "\<Space>"

"----------------------------------------------------
" Vimタブ表示
"----------------------------------------------------
" The prefix key.
nnoremap    [Tag]   <Nop>
" Tab jump
nmap    t [Tag]
" t1 で1番左のタブ、t2 で1番左から2番目のタブにジャンプ
for n in range(1, 9)
  execute 'nnoremap <silent> [Tag]'.n  ':<C-u>tabnext'.n.'<CR>'
endfor

" tt 新しいタブを一番右に作る
nnoremap <silent> [Tag]t :<C-u> $tabnew<CR>
" tq タブを閉じる
nnoremap <silent> [Tag]q :<C-u> tabclose<CR>
" tl 次のタブ
nnoremap <silent> [Tag]l :<C-u> tabnext<CR>
" th 前のタブ
nnoremap <silent> [Tag]h :<C-u> tabprevious<CR>

"----------------------------------------------------
" Denite
"----------------------------------------------------
"# noremap <silent> <C-u><C-p> :<C-u>Denite file_rec<CR>
"# noremap <silent> <C-u><C-g> :<C-u>Denite grep<CR>
"# noremap <silent> <C-u><C-i> :<C-u>DeniteCursorWord grep<CR>
"# noremap <silent> <C-u><C-u> :<C-u>Denite file_mru<CR>
"# noremap <silent> <C-u><C-r> :<C-u>Denite -resume<CR>

"----------------------------------------------------
" CtrlP
"----------------------------------------------------
let g:ctrlp_map = '<Nop>'
set runtimepath^=~/.vim/bundle/ctrlp.vim
nnoremap <Leader>p :CtrlP<CR>
" ドットファイルを表示する
"let g:ctrlp_show_hidden = 1
" キャッシュディレクトリ
let g:ctrlp_cache_dir = $HOME.'/.cache/ctrlp'
" キャッシュを終了時に削除しない
"let g:ctrlp_clear_cache_on_exit = 1
" 遅延再描画
let g:ctrlp_lazy_update = 1
" ルートパスと認識させるためのファイル
let g:ctrlp_root_markers = ['Gemfile', 'pom.xml', 'build.xml']
" CtrlPのウィンドウ最大高さ
let g:ctrlp_max_height = 20
" 無視するディレクトリ
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ 'link': 'some_bad_symbolic_links',
  \ }
" Agで検索
if executable('ag')
  let g:ctrlp_use_caching=0
  let g:ctrlp_user_command='ag %s -i --nocolor --nogroup -g ""'
endif

"# "----------------------------------------------------
"# " NERDTree
"# "----------------------------------------------------
"# " ブックマーク初期表示
"# let g:NERDTreeShowBookmarks=1
"# "
"# let g:NERDTreeChDirMode=2
"# " windowサイズ設定
"# let g:NERDTreeWinSize=20
"# " 表示したくないファイル、ディレクトリ
"# let g:NERDTreeIgnore=['\.DS_Store$', '\.swp$', '\~$', '\.so']
"# " vim起動時に常に表示
"# autocmd vimenter * NERDTree
"# " NERDTreeだけが残る場合はvim終了
"# autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

"----------------------------------------------------
" TagBar
"----------------------------------------------------
noremap <Leader>\ :TagbarToggle<CR>  

"----------------------------------------------------
" vim-go 
"----------------------------------------------------
let g:go_highlight_functions = 0
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_list_type = "quickfix"
"let g:go_fmt_fail_silently = 1
let g:go_def_mode = 'godef'
let g:go_decls_includes = "func,type"

au FileType go nmap <leader>. <Plug>(go-run)
au FileType go nmap <leader>, <Plug>(go-run-tab)
au FileType go nmap <leader>b <Plug>(go-build)
au FileType go nmap <leader>t <Plug>(go-test)
au FileType go nmap <leader>c <Plug>(go-coverage)
au FileType go nmap <Leader>i <Plug>(go-info)

au FileType go nmap <Leader>gd <Plug>(go-doc)
au FileType go nmap <Leader>gv <Plug>(go-doc-vertical)
au FileType go nmap <Leader>gb <Plug>(go-doc-browser)
au FileType go nmap <Leader>d <Plug>(go-def)
au FileType go nmap <Leader>n <Plug>(go-def-tab)
au FileType go nmap <Leader>v <Plug>(go-def-vertical)
au FileType go nmap <Leader>s <Plug>(go-def-split)
au FileType go nmap <Leader>r <Plug>(go-referrers)
au FileType go noremap <Leader>l :GoDeclsDir<cr>

au FileType go :highlight goErr cterm=bold ctermfg=214
au FileType go :match goErr /\<err\>/

"----------------------------------------------------
" Key Map Assignment
"----------------------------------------------------
"noremap ; :
"noremap : ;
noremap <S-h>   ^
noremap <S-l>   $
"noremap <S-j>   }
"noremap <S-k>   {
nnoremap <C-n> :cn<CR>
nnoremap <C-p> :cp<CR>
"nnoremap <Leader>j :GtagsCursor<CR>
"nnoremap <Leader>l :Gtags -f %<CR>
nnoremap <Leader>a :copen<CR>
nnoremap <Leader>q :cclose<CR>

noremap <Space>g :<C-u>Ag <C-r><C-w> *<CR>
noremap <Space>G :<C-u>Ag <C-r><C-w><Space>

nnoremap <silent><Esc><Esc> :<C-u>noh<CR>

"----------------------------------------------------
" GNU GLOBAL(gtags)
"----------------------------------------------------
let g:Gtags_Auto_Update = 1

"----------------------------------------------------
" Vim Session
"----------------------------------------------------
"au VimLeave * mks! ~/.vim.session
noremap <Space>= :<C-u>mks! ~/.vim.session<CR>
noremap <Space>` :<C-u>source ~/.vim.session<CR>
