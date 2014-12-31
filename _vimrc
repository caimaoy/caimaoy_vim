"==========================================
" Display Settings 展示/排版等界面格式设置
"==========================================
"
"显示当前的行号列号：
set ruler
""在状态栏显示正在输入的命令
set showcmd
" 左下角显示当前vim模式
set showmode

" 在上下移动光标时，光标的上方或下方至少会保留显示的行数
set scrolloff=7
set cc=80

" set winwidth=79
"==========================================
" Display Settings 展示/排版等界面格式设置END
"==========================================
"
"
"==========================================
" General Settings 基础设置
"==========================================

set autoread            " 文件修改之后自动载入。
set shortmess=atI       " 启动的时候不显示那个援助索马里儿童的提示

" 备份,到另一个位置. 防止误删, 目前是取消备份
set backup
set backupext=.bak
set backupdir=/tmp/vimbk/

" 取消备份。 视情况自己改
"set nobackup
" 关闭交换文件
set noswapfile

set cursorcolumn
set cursorline          " 突出显示当前行
"==========================================
" General Settings 基础设置 END
"==========================================

set nocompatible
set tags=./tags,tags
"set tags=./tags,tags,E:/Projects/php/tags

source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave mswin

autocmd GUIEnter * simalt ~x

set guioptions=EgrLt
map <silent> <M-m> :if &guioptions =~# 'T' <Bar>
        \set guioptions-=T <Bar>
        \set guioptions-=m <bar>
    \else <Bar>
        \set guioptions+=T <Bar>
        \set guioptions+=m <Bar>
    \endif<CR>
"set bin noendofline
set nu ai nobackup guifont=consolas:h11
set guifont=Fixedsys:h12:cGB2312
set guifont=Inconsolata:h12:cANSI
set guifont=Bitstream_Vera_Sans_Mono:h10:cANSI
set gfw=Yahei_Mono:h10.5:cGB2312


set autochdir
"lcd %:p:h
set autoindent smartindent
:hi normal guibg=black guifg=white

set fileencoding=utf-8
set fileencodings=GB232,utf-8,gbk,ucs-bom,GB8030,default,latin
set ambiwidth=double

if has("multi_byte")
    set encoding=utf-8
    set termencoding=utf-8
    set langmenu=zh_CN.UTF-8
    language message zh_CN.UTF-8
endif

set expandtab
set tabstop=4 softtabstop=4 shiftwidth=4
set mouse=a selection=exclusive selectmode=mouse,key

if has('gui_running')
  let do_syntax_sel_menu=1
endif

if bufname('')==''
    cd $HOME
endif

autocmd FileType php                set dictionary+=D:\ShellAlias\backup\php.list
autocmd FileType javascript         set dictionary+=D:\ShellAlias\backup\js.list
autocmd FileType html               set dictionary+=D:\ShellAlias\backup\js.list
autocmd BufNewFile  *.html 0r       E:\Projects\others\vim\html\model.html
imap <C-u> <C-x><C-k>

map <F4> :NERDTreeToggle<CR>

map <F5> :call CompileRunGcc()<CR>
func! CompileRunGcc()
    exec "w"
    exec "!gcc %"
    exec "!a"
endfunc

map <F6> :call CompileRunGpp()<CR>
func CompileRunGpp()
    exec "w"
    exec "!gpp %"
    exec "!a"
endfunc

"map <F7> :call CompileRunJava()<CR>
"func CompileRunJava()
"    exec "w"
"    exec "!javac %"
"    exec "!java %<"
"endfunc

"map <F8> :call RunPhp()<CR>
"func RunPhp()
"    exec "w"
"    exec "!php %"
"endfunc

"F7 call PEP8
"map <F7> :call <SID>Pep8()<CR>

"map <F9> :RunHtml<CR>

"标签导航
"Bundle 'majutsushi/tagbar'

let mapleader = ","
let g:mapleader = ","

nmap <F9> :TagbarToggle<CR>
let g:tagbar_autofocus = 1

map <F12> :w!<CR> :!python %<CR>

map \at :call AppendTime()<CR>
func AppendTime(...)
    "let format = '%c'
    let format = '%Y-%m-%d %H:%M:%S'
    let editinfo = ['/*', ' * Last modified time: '.strftime(format,getftime(expand("%:p"))), ' * Edit time: '.strftime(format,localtime()), ' * File name: '.expand('%'), ' */']
    call append(line('.'),editinfo)
endfunc

map \cy :call AppendTimePython()<CR>
func AppendTimePython(...)
    "let format = '%c'
    let format = '%Y-%m-%d %H:%M:%S'
    let editinfo = ["'''", 'Last modified time: '.strftime(format,getftime(expand("%:p"))), 'Edit time: '.strftime(format,localtime()), 'File name: '.expand('%'), 'Edit by caimaoy', "'''"]
    call append(line('.'),editinfo)
endfunc

map \main :call MainPython()<CR>
func MainPython(...)
    let mainString = ["if __name__ == '__main__':", '    pass']
    call append(line('.'), mainString)
    return 1
endfunc

map \py :call Py()<CR>
func Py(...)
    call Utf8()
    call MainPython()
    call append(line('.'), [''])
    call AppendTimePython()
    return 1
endfunc

map \je :call JSEscape()<CR>
func JSEscape(...)
    let JSString = ['<script type="text/javascript">','//<![CDATA[','//]]>','</script>']
    call append(line('.'),JSString)
    call cursor(line(".")+2,11111111)
    return 1
endfunc

map \fs :call FileSet()<CR>
func FileSet(...)
    let @z = '/* vim: set expandtab tabstop=4 shiftwidth=4 softtabstop=4: */'
    "exec "pu! z"
    exec ":call append(line('.'),@z)"
    return 1
endfunc

map \utf :call Utf8()<CR>
func Utf8(...)
    let Utf8String = ['# -*- coding: UTF-8 -*-']
    call append(line(0), Utf8String)
    return 1
endfunc


map <C-n> :tabnew<CR>
map <S-Left> :tabp<CR>
map <S-Right> :tabn<CR>
for a in range(1,9)
    exe 'map <A-' . a . '> ' . a . 'gt'
endfor

map \tt :TlistToggle<CR>
map <S-Up> :TlistToggle<CR>
"let Tlist_Ctags_Cmd = 'D:\Projects\shell\ctags.exe'
let Tlist_Use_Right_Window = 1
let Tlist_GainFocus_On_ToggleOpen = 1

map \dsl :g/^[     ]*$/d<CR>
map \dse :%s/[     ]*$//g<CR>
map \t2s :%s/\t/    /g<CR>
map \s2t :%s/    /\t/g<CR>
map \lcd :lcd %:p:h<CR>
"map \cd :cd %:p:h<CR>
map \ed :Xpr<CR>
map \df :call Differ()<CR>
func Differ()
    exec ":set diff"
    exec ":set scrollbind"
    exec ":set guioptions+=b"
endfunc
map \ndf :call Notdiffer()<CR>
func Notdiffer()
    exec ":set nodiff"
    exec ":set noscrollbind"
    exec ":set guioptions-=b"
endfunc

map \cmd :!Start<CR>
map <silent> <S-Down> :Start<CR>

map \nt :NERDTreeToggle<CR>
map <S-CR> :NERDTreeToggle<CR>
let NERDTreeIgnore=['\.exe$','\.gif$','\.png$','\.jpeg$','\.swf$','\.ttc$','^CVS$','^SVN$']

set diffexpr=MyDiff()
function MyDiff()
    let opt = '-a --binary '
    if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
    if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
    let arg1 = v:fname_in
    if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
    let arg2 = v:fname_new
    if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
    let arg3 = v:fname_out
    if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
    let eq = ''
    if $VIMRUNTIME =~ ' '
        if $VIMRUNTIME =~ ' '
            let cmd = '"' . $VIMRUNTIME . '\diff"'
            let eq = '""'
        else
            let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
        endif
    else
        let cmd = $VIMRUNTIME . '\diff'
    endif
    silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction

"Following is html editing settings
if exists("b:did_ftplugin")
    finish
endif

let b:html_mode = 1
let xml_use_xhtml = 1

if !exists("*HtmlAttribCallback")
function HtmlAttribCallback( xml_tag )
  if a:xml_tag ==? "table"
      return "cellpadding=\"0\" cellspacing=\"0\" border=\"0\""
  elseif a:xml_tag ==? "link"
      return "href=\"/site.css\" rel=\"StyleSheet\" type=\"text/css\""
  elseif a:xml_tag ==? "body"
      return "bgcolor=\"white\""
  elseif a:xml_tag ==? "frame"
      return "name=\"NAME\" src=\"/\" scrolling=\"auto\" noresize"
  elseif a:xml_tag ==? "frameset"
      return "rows=\"0,*\" cols=\"*,0\" border=\"0\""
  elseif a:xml_tag ==? "img"
      return "src=\"\" width=\"0\" height=\"0\" border=\"0\" alt=\"\" /"
  elseif a:xml_tag ==? "input"
      return 'type="" value=""'
  elseif a:xml_tag ==? "a"
      if has("browse")
          " Look up a file to fill the href. Used in local relative file
          " links. typeing your own href before closing the tag with `>'
          " will override this.
          let cwd = getcwd()
          let cwd = substitute (cwd, "\\", "/", "g")
          let href = browse (0, "Link to href...", getcwd(), "")
          let href = substitute (href, cwd . "/", "", "")
          let href = substitute (href, " ", "%20", "g")
      else
          let href = ""
      endif
      return "href=\"" . href . "\""
  else
      return 0
  endif
endfunction
endif

" On to loading xml.vim
runtime ftplugin/xml.vim

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CTags的设定
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 按照名称排序
let Tlist_Sort_Type = "name"

" 在右侧显示窗口
let Tlist_Use_Right_Window = 0

" 压缩方式
let Tlist_Compart_Format = 0

" 如果只有一个buffer，kill窗口也kill掉buffer
let Tlist_Exist_OnlyWindow = 1

" 不要关闭其他文件的tags
let Tlist_File_Fold_Auto_Close = 0

" 不要显示折叠树
let Tlist_Enable_Fold_Column = 1

map <F3> :silent! Tlist<CR> "按下F3就可以呼出了
let Tlist_Ctags_Cmd='ctags' "因为我们放在环境变量里，所以可以直接执行
"let Tlist_Show_One_File=2 "让taglist可以同时展示多个文件的函数列表，如果想只有1个，设置为1
"let Tlist_File_Fold_Auto_Close=1 "非当前文件，函数列表折叠隐藏
nnoremap <CR> :nohlsearch<CR><CR>
nnoremap <silent> <space> <C-F>

let g:winManagerWindowLayout='FileExplorer|TagList'
nmap wm :WMToggle<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CTags的设定 End
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" pydiction
"let g:pydiction_location='C:\Program Files (x86)\Vim\vimfiles\ftplugin\pydiction\complete-dict'
"let g:pydiction_location='C:\Users\yournb\Desktop\vim73-x64\vimfiles\ftplugin\complete-dict'
let g:pydiction_location='D:\Program Files\Vim\vimfiles\bundle\Pydiction-master\complete-dict'
filetype plugin on
set autoindent
syntax enable
set softtabstop=4
set shiftwidth=4
set number
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 代码折叠
: set foldmethod=indent
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set expandtab
filetype plugin indent on
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"pathogen
call pathogen#infect()
"pyflakes-vim
filetype on
filetype plugin on
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"vim-colors-solarized
"syntax enable
"set background=dark
"colorscheme solarized
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"another one
"let g:solarized_termtrans=1
"let g:solarized_contrast="normal"
"let g:solarized_visibility="normal"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
execute pathogen#infect()
set laststatus=2
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"rainbow_parentheses
let g:rbpt_colorpairs = [
    \ ['brown',       'RoyalBlue3'],
    \ ['Darkblue',    'SeaGreen3'],
    \ ['darkgray',    'DarkOrchid3'],
    \ ['darkgreen',   'firebrick3'],
    \ ['darkcyan',    'RoyalBlue3'],
    \ ['darkred',     'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['brown',       'firebrick3'],
    \ ['gray',        'RoyalBlue3'],
    \ ['black',       'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['Darkblue',    'firebrick3'],
    \ ['darkgreen',   'RoyalBlue3'],
    \ ['darkcyan',    'SeaGreen3'],
    \ ['darkred',     'DarkOrchid3'],
    \ ['red',         'firebrick3'],
    \ ]

let g:rbpt_max = 16
let g:rbpt_loadcmd_toogle_ = 0

au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"indentLine
let g:indentLine_color_gui = "#224222"
let g:indentLine_char = '|'
"┆┊┇┋┃'
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 缩进配置

set smartindent   " Smart indent
set autoindent    " 打开自动缩进
" never add copyindent, case error   " copy the previous indentation on autoindenting

" tab相关变更
set tabstop=4     " 设置Tab键的宽度        [等同的空格个数]
set shiftwidth=4  " 每一次缩进对应的空格数
set softtabstop=4 " 按退格键时可以一次删掉 4 个空格
set smarttab      " insert tabs on the start of a line according to shiftwidth, not tabstop 按退格键时可以一次删掉 4 个空格
set expandtab     " 将Tab自动转化成空格    [需要输入真正的Tab键时，使用 Ctrl+V + Tab]
set shiftround    " 缩进时，取整 use multiple of shiftwidth when indenting with '<' and '>'

" A buffer becomes hidden when it is abandoned
set hidden
set wildmode=list:longest
set ttyfast


" 相对行号      行号变成相对，可以用 nj  nk   进行跳转 5j   5k 上下跳5行
set relativenumber number
au FocusLost * :set norelativenumber number
au FocusGained * :set relativenumber
" 插入模式下用绝对行号, 普通模式下用相对
autocmd InsertEnter * :set norelativenumber number
autocmd InsertLeave * :set relativenumber
function! NumberToggle()
  if(&relativenumber == 1)
    set norelativenumber number
  else
    set relativenumber
  endif
endfunc
nnoremap <C-m> :call NumberToggle()<cr>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set tags+=tags
set autochdir

map ,,, :syntax on<CR>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"YcmCompelter

"nnoremap <leader>gl :YcmCompleter GoToDeclaration<CR>
"nnoremap <leader>gf :YcmCompleter GoToDefinition<CR>
"nnoremap <leader>gg :YcmCompleter GoToDefinitionElseDeclaration<CR>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" for jinja2 highlight
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set nocompatible
syntax on
filetype off
"set rtp+=~/.vim/bundle/Vundle.vim/
"vundle 的下载路径windows 和 linux 有差异
"set rtp+=D:\Program Files\Vim\vimfiles\bundle\vundle\
"set rtp+=$VIM/vimfiles/bundle/vundle/
"call vundle#rc()
"set rtp+=$VIM/vimfiles/bundle/vundle/
"call vundle#rc('$VIM/vimfiles/bundle/')


if has('win32') || has('win64')
  "set rtp+=~/vimfiles/bundle/vundle/
  "call vundle#rc('$HOME/vimfiles/bundle/')
    set rtp+=$VIM/vimfiles/bundle/vundle/
    call vundle#rc('$VIM/vimfiles/bundle/')
else
  " Usual quickstart instructions
  set rtp+=~/.vim/bundle/vundle/
  call vundle#rc()
endif

"
Bundle 'gmarik/Vundle.vim'
Bundle 'Glench/Vim-Jinja2-Syntax'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
"call vundle#rc('$VIM/vimfiles/bundle/')
filetype plugin indent on

" YouCompleteMe 功能
" 补全功能在注释中同样有效
let g:ycm_complete_in_comments=1
" 允许 vim 加载 .ycm_extra_conf.py 文件，不再提示
let g:ycm_confirm_extra_conf=0
" 开启 YCM 基于标签引擎
let g:ycm_collect_identifiers_from_tags_files=1
" 引入 C++ 标准库tags，这个没有也没关系，只要.ycm_extra_conf.py文件中指定了正确的标准库路径
set tags+=/data/misc/software/misc./vim/stdcpp.tags
" YCM 集成 OmniCppComplete 补全引擎，设置其快捷键
inoremap <leader>; <C-x><C-o>
" 补全内容不以分割子窗口形式出现，只显示补全列表
set completeopt-=preview
" 从第一个键入字符就开始罗列匹配项
let g:ycm_min_num_of_chars_for_completion=1
" 禁止缓存匹配项，每次都重新生成匹配项
let g:ycm_cache_omnifunc=0
" 语法关键字补全
let g:ycm_seed_identifiers_with_syntax=1
" 修改对C函数的补全快捷键，默认是CTRL + space，修改为ALT + ;
let g:ycm_key_invoke_completion = ''
" 设置转到定义处的快捷键为ALT + G，这个功能非常赞
"nmap <M-g> :YcmCompleter GoToDefinitionElseDeclaration <C-R>=expand("<cword>")<CR><CR>
nmap <leader>gd :YcmCompleter GoToDefinitionElseDeclaration <C-R>=expand("<cword>")<CR><CR>

"let g:ycm_global_ycm_extra_conf = "D:\windows上YoucompeleteMe完整包\vim-7.4.193-python-2.7-python-3.3-ruby-2.0.0-lua-5.2-windows-x86\.ycm_extra_conf.py"
let g:ycm_global_ycm_extra_conf = "$VIM/vimfiles/bundle/.ycm_extra_conf.py"

" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<M-u>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"





