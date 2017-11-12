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
if dein#load_state('/Users/shimauchi/.vim/bundle/.')
  call dein#begin('/Users/shimauchi/.vim/bundle/.')

"  " Let dein manage dein
"  " Required:
"  call dein#add('/Users/shimauchi/.vim/bundle/./repos/github.com/Shougo/dein.vim')
"
"  " Add or remove your plugins here:
"  call dein#add('Shougo/neosnippet.vim')
"  call dein#add('Shougo/neosnippet-snippets')
"
"
"  " You can specify revision/branch/tag.
"  call dein#add('Shougo/vimshell', { 'rev': '3787e5' })

  " プラグインリストを収めた TOML ファイル置き場
  let s:rc_dir = expand('~/.vim/rc')

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
  autocmd! FileType smarty     setlocal shiftwidth=2 tabstop=2 softtabstop=2
  autocmd! FileType css        setlocal shiftwidth=2 tabstop=2 softtabstop=2
  autocmd! FileType javascript setlocal shiftwidth=2 tabstop=2 softtabstop=2
augroup END
set backspace=2

" マウス有効
set mouse=a
set ttymouse=xterm2

" Copy/Paste/Cut
set clipboard=unnamed,autoselect


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

" tc 新しいタブを一番右に作る
map <silent> [Tag]c :tablast <bar> tabnew<CR>
" tx タブを閉じる
map <silent> [Tag]x :tabclose<CR>
" tn 次のタブ
map <silent> [Tag]n :tabnext<CR>
" tp 前のタブ
map <silent> [Tag]p :tabprevious<CR>

"----------------------------------------------------
" neosnippet
"----------------------------------------------------
" Plugin key-mappings.
imap <C-e>     <Plug>(neosnippet_expand_or_jump)
smap <C-e>     <Plug>(neosnippet_expand_or_jump)
xmap <C-e>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
"imap <expr><TAB>
" \ pumvisible() ? "\<C-n>" :
" \ neosnippet#expandable_or_jumpable() ?
" \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
"# " エンターキーで補完候補の確定. スニペットの展開もエンターキーで確定
"# imap <expr><CR> neosnippet#expandable() ? "<Plug>(neosnippet_expand_or_jump)" : pumvisible()
"#                                        \? "<C-y>" : "<CR>"
"# " タブキーで補完候補の選択. スニペット内のジャンプもタブキーでジャンプ
"# imap <expr><TAB> pumvisible() ? "<C-n>" : neosnippet#jumpable()
"#                              \? "<Plug>(neosnippet_expand_or_jump)" : "<TAB>"

" For conceal markers.
if has('conceal')
    set conceallevel=2 concealcursor=niv
endif

"----------------------------------------------------
" neocomplete
"----------------------------------------------------
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
" 区切り文字まで補完する
let g:neocomplete#enable_auto_delimiter = 1
" 1文字目の入力から補完のポップアップを表示
let g:neocomplete#auto_completion_start_length = 1

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
    return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"

" バックスペースで補完のポップアップを閉じる
inoremap <expr><BS> neocomplete#smart_close_popup()."<C-h>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

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

"----------------------------------------------------
" Unite
"----------------------------------------------------
" insert modeで開始
let g:unite_enable_start_insert = 1

" 大文字小文字を区別しない
let g:unite_enable_ignore_case = 1
let g:unite_enable_smart_case = 1

" grep検索
nnoremap <silent> ,g  :<C-u>Unite grep:. -buffer-name=search-buffer -no-empty<CR>

" カーソル位置の単語をgrep検索
nnoremap <silent> ,cg :<C-u>Unite grep:. -buffer-name=search-buffer -no-empty<CR><C-R><C-W><CR>

" grep検索結果の再呼出
nnoremap <silent> ,r  :<C-u>UniteResume search-buffer -no-empty<CR>

" unite grep に ag(The Silver Searcher) を使う
if executable('ag')
  let g:unite_source_grep_command = 'ag'
  let g:unite_source_grep_default_opts = '--nogroup --nocolor --column'
  let g:unite_source_grep_recursive_opt = ''
endif

"#"----------------------------------------------------
"#" NERDTree
"#"----------------------------------------------------
"#" ブックマーク初期表示
"#let g:NERDTreeShowBookmarks=1
"#"
"#let g:NERDTreeChDirMode=2
"#" windowサイズ設定
"#let g:NERDTreeWinSize=20
"#" 表示したくないファイル、ディレクトリ
"#let g:NERDTreeIgnore=['\.DS_Store$', '\.swp$', '\~$', '\.so']
"#" vim起動時に常に表示
"#autocmd vimenter * NERDTree
"#" NERDTreeだけが残る場合はvim終了
"#autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

"----------------------------------------------------
" pathogen
"----------------------------------------------------
execute pathogen#infect()
syntax on
filetype plugin indent on

"----------------------------------------------------
" syntastic
"----------------------------------------------------
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 2
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_auto_jump = 1
let g:syntastic_loc_list_height = 5

let g:syntastic_javascript_checkers=['eslint']
let g:syntastic_scss_checkers = ['scss_lint']
let g:syntastic_php_checkers = ['php', 'phpcs', 'phpmd']
let g:syntastic_go_checkers = ['govet', 'errcheck', 'go']

"#"----------------------------------------------------
"#" tagbar
"#"----------------------------------------------------
"#" windowサイズ
"#let g:tagbar_width=20
"#" 起動時に常に表示
"#autocmd vimenter *.php TagbarOpen

"#"----------------------------------------------------
"#" vim-tags
"#"----------------------------------------------------
"#let g:vim_tags_project_tags_command = "/usr/local/Cellar/ctags/5.8_1/bin/ctags -f .tags -R . 2>/dev/null"
"#let g:vim_tags_auto_generate = 1

"#"----------------------------------------------------
"#" ctags
"#"----------------------------------------------------
"#" phpファイル用tags
"#au BufNewFile,BufRead *.php set tags+=$HOME/.tags/php.tag


"#"----------------------------------------------------
"#" neocomplete-php
"#"----------------------------------------------------
"#let g:neocomplete_php_locale = 'ja'

"#"----------------------------------------------------
"#" PHP Documentor for VIM
"#"----------------------------------------------------
"#inoremap <C-P> <Esc>:call PhpDocSingle()<CR>
"#nnoremap <C-P> :call PhpDocSingle()<CR>
"#vnoremap <C-P> :call PhpDocSingle()<CR>

"----------------------------------------------------
" vim-go 
"----------------------------------------------------
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
"let g:go_list_type = "quickfix"
"let g:go_fmt_fail_silently = 1

au FileType go nmap <leader>r <Plug>(go-run)
au FileType go nmap <leader>b <Plug>(go-build)
au FileType go nmap <leader>t <Plug>(go-test)
au FileType go nmap <leader>c <Plug>(go-coverage)
au FileType go nmap <Leader>i <Plug>(go-info)

au FileType go nmap <Leader>gd <Plug>(go-doc)
au FileType go nmap <Leader>gv <Plug>(go-doc-vertical)
au FileType go nmap <Leader>gb <Plug>(go-doc-browser)

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
nnoremap <Leader>j :GtagsCursor<CR>
nnoremap <Leader>l :Gtags -f %<CR>
nnoremap <Leader>q :cclose<CR>

noremap <Space>8 :<C-u>Ag <C-r><C-w> *<CR>
noremap <Space>9 :<C-u>Ag <C-r><C-w><Space>

nnoremap <silent><Esc><Esc> :<C-u>noh<CR>

"----------------------------------------------------
" GNU GLOBAL(gtags)
"----------------------------------------------------
let g:Gtags_Auto_Update = 1

"----------------------------------------------------
" Vim Session
"----------------------------------------------------
"au VimLeave * mks! ~/.vim.session
