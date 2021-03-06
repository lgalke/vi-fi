" Vim color scheme
" Name:         vividwolf.vim
" Author:       Lukas Galke <vim@lpag.de>
" Version:      0.1

" Based on vividchalk by Tim Pope and a little bit of badwolf by Steve Losh
" Distributable under the same terms as Vim itself (see :help license)

if has("gui_running")
    set background=dark
endif
hi clear
if exists("syntax_on")
   syntax reset
endif

let colors_name = "vividwolf"

" First two functions adapted from inkpot.vim

" map a urxvt cube number to an xterm-256 cube number
fun! s:M(a)
    return strpart("0245", a:a, 1) + 0
endfun

" map a urxvt colour to an xterm-256 colour
fun! s:X(a)
    if &t_Co == 88
        return a:a
    else
        if a:a == 8
            return 237
        elseif a:a < 16
            return a:a
        elseif a:a > 79
            return 232 + (3 * (a:a - 80))
        else
            let l:b = a:a - 16
            let l:x = l:b % 4
            let l:y = (l:b / 4) % 4
            let l:z = (l:b / 16)
            return 16 + s:M(l:x) + (6 * s:M(l:y)) + (36 * s:M(l:z))
        endif
    endif
endfun

function! E2T(a)
    return s:X(a:a)
endfunction

function! s:choose(mediocre,good)
    if &t_Co != 88 && &t_Co != 256
        return a:mediocre
    else
        return s:X(a:good)
    endif
endfunction

function! s:hifg(group,guifg,first,second,...)
    if a:0 && &t_Co == 256
        let ctermfg = a:1
    else
        let ctermfg = s:choose(a:first,a:second)
    endif
    exe "highlight ".a:group." guifg=".a:guifg." ctermfg=".ctermfg
endfunction

function! s:hibg(group,guibg,first,second)
    let ctermbg = s:choose(a:first,a:second)
    exe "highlight ".a:group." guibg=".a:guibg." ctermbg=".ctermbg
endfunction

hi link railsMethod         PreProc
hi link rubyDefine          Keyword
hi link rubySymbol          Constant
hi link rubyAccess          rubyMethod
hi link rubyAttribute       rubyMethod
hi link rubyEval            rubyMethod
hi link rubyException       rubyMethod
hi link rubyInclude         rubyMethod
hi link rubyStringDelimiter rubyString
hi link rubyRegexp          Regexp
hi link rubyRegexpDelimiter rubyRegexp
"hi link rubyConstant        Variable
"hi link rubyGlobalVariable  Variable
"hi link rubyClassVariable   Variable
"hi link rubyInstanceVariable Variable
hi link javascriptRegexpString  Regexp
hi link javascriptNumber        Number
hi link javascriptNull          Constant
highlight link diffAdded        String
highlight link diffRemoved      Statement
highlight link diffLine         PreProc
highlight link diffSubname      Comment

call s:hifg("Normal","#EEEEEE","White",87)
if &background == "light" || has("gui_running")
    hi Normal guibg=Black ctermbg=Black
else
    hi Normal guibg=Black ctermbg=NONE
endif
highlight StatusLine    guifg=Black   guibg=#aabbee gui=bold ctermfg=Black ctermbg=White  cterm=bold
highlight StatusLineNC  guifg=#444444 guibg=#aaaaaa gui=none ctermfg=Black ctermbg=Grey   cterm=none

highlight Ignore        ctermfg=Black
highlight WildMenu      guifg=Black   guibg=#ffff00 gui=bold ctermfg=Black ctermbg=Yellow cterm=bold
highlight Cursor        guifg=Black guibg=White ctermfg=Black ctermbg=White
call s:hibg("ColorColumn","#333333","DarkGrey",81)
call s:hibg("CursorLine","#333333","DarkGrey",81)
highlight CursorLine term=reverse cterm=None
call s:hibg("CursorColumn","#333333","DarkGrey",81)
highlight NonText       guifg=#404040 ctermfg=8
highlight SpecialKey    guifg=#404040 ctermfg=8
highlight Directory     none
high link Directory     Identifier
highlight ErrorMsg      guibg=Red ctermbg=DarkRed guifg=NONE ctermfg=NONE
" highlight Search        guifg=NONE ctermfg=NONE gui=none cterm=none
" Search colors from badwolf
highlight IncSearch term=reverse cterm=bold ctermfg=16 ctermbg=39 gui=bold guifg=#000000 guibg=#0a9dff
highlight Search term=reverse cterm=bold ctermfg=16 ctermbg=221 gui=bold guifg=#000000 guibg=#fade3e
" call s:hibg("Search"    ,"#555555","DarkBlue",81)
" highlight IncSearch     guifg=White guibg=Black ctermfg=White ctermbg=Black
highlight MoreMsg       guifg=#00AA00 ctermfg=Green
highlight LineNr        guifg=#DDEEFF ctermfg=White
call s:hibg("LineNr"    ,"#222222","DarkBlue",80)
highlight Question      none
high link Question      MoreMsg
highlight Title         guifg=Magenta ctermfg=Magenta
highlight VisualNOS     gui=none cterm=none
call s:hibg("Visual"    ,"#555577","LightBlue",83)
call s:hibg("VisualNOS" ,"#444444","DarkBlue",81)
" 18
" call s:hibg("MatchParen","#1100AA","DarkBlue",33)
highlight MatchParen term=reverse cterm=bold ctermfg=221 ctermbg=235 gui=bold guifg=#fdae3e guibg=#242321
highlight WarningMsg    guifg=Red ctermfg=Red
highlight Error         ctermbg=DarkRed
highlight SpellBad      ctermbg=DarkRed
" FIXME: Comments
highlight SpellRare     ctermbg=DarkMagenta
highlight SpellCap      ctermbg=DarkBlue
highlight SpellLocal    ctermbg=DarkCyan

"49 pink, 96 smooth blue, 119 light violet are nice
call s:hibg("Folded"    ,"#110077","DarkBlue",96) "17
call s:hifg("Folded"    ,"#aaddee","LightCyan",63)
" highlight Folded ctermbg=92 ctermfg=16 cterm=bold
highlight FoldColumn    none
high link FoldColumn    Folded
highlight DiffAdd       ctermbg=42 ctermfg=16 guibg=DarkRed cterm=bold
highlight DiffChange    ctermbg=208 ctermfg=16 guifg=DarkRed guibg=Yellow cterm=bold
highlight DiffDelete    ctermbg=220 ctermfg=16 gui=bold guifg=Yellow guibg=DarkRed cterm=bold
highlight DiffText      ctermbg=DarkRed
highlight DiffText      cterm=bold ctermbg=9 gui=bold guibg=Red

" highlight Pmenu         guifg=White ctermfg=White gui=bold cterm=bold
" highlight PmenuSel      guifg=White ctermfg=White gui=bold cterm=bold
highlight Pmenu term=reverse cterm=bold ctermfg=16 ctermbg=92 gui=bold guifg=#fdae3e guibg=#242321
" call s:hibg("Pmenu"     ,"#000099","Blue",25) "18
highlight PmenuSel term=reverse cterm=bold ctermfg=16 ctermbg=82 gui=bold guifg=#fdae3e guibg=#242321
" call s:hibg("Pmenu"     ,"#000099","Blue",25) "18
" call s:hibg("PmenuSel"  ,"#5555ff","DarkCyan",39)
highlight PmenuSbar     guibg=Grey ctermbg=Grey
highlight PmenuThumb    guibg=White ctermbg=White
highlight TabLine       gui=underline cterm=underline
call s:hifg("TabLine"   ,"#bbbbbb","LightGrey",85)
call s:hibg("TabLine"   ,"#333333","DarkGrey",80)
highlight TabLineSel    guifg=White guibg=Black ctermfg=White ctermbg=Black
highlight TabLineFill   gui=underline cterm=underline
call s:hifg("TabLineFill","#bbbbbb","LightGrey",85)
call s:hibg("TabLineFill","#808080","Grey",83)

hi Type gui=none
hi Statement gui=none
if !has("gui_mac")
    " Mac GUI degrades italics to ugly underlining.
    hi Comment gui=italic
    hi railsUserClass  gui=italic
    hi railsUserMethod gui=italic
endif
hi Identifier cterm=none
" Commented numbers at the end are *old* 256 color values
"highlight PreProc       guifg=#EDF8F9
call s:hifg("Comment"        ,"#9933CC","DarkMagenta",34) " 92
" 26 instead?
call s:hifg("Constant"       ,"#339999","DarkCyan",21) " 30
call s:hifg("rubyNumber"     ,"#CCFF33","Yellow",60) " 190
call s:hifg("String"         ,"#66FF00","LightGreen",44,82) " 82
call s:hifg("Identifier"     ,"#FFCC00","Yellow",72) " 220
call s:hifg("Statement"      ,"#FF6600","Brown",68) " 202
call s:hifg("PreProc"        ,"#AAFFFF","LightCyan",47) " 213
call s:hifg("railsUserMethod","#AACCFF","LightCyan",27)
call s:hifg("Type"           ,"#AAAA77","Grey",57) " 101
call s:hifg("railsUserClass" ,"#AAAAAA","Grey",7) " 101
"49 pink
"25 grass
"60 lime
"65 pink
"70 rose
call s:hifg("Special"        ,"#33AA00","DarkGreen",23) " 24, 7
call s:hifg("Regexp"         ,"#44B4CC","DarkCyan",21) " 74
call s:hifg("rubyMethod"     ,"#DDE93D","Yellow",77) " 191
"highlight railsMethod   guifg=#EE1122 ctermfg=1

function! s:setup_statusline(...)
   augroup vividwolf_insert_toggling
      autocmd!
      if a:0 >= 2
         exe 'autocmd InsertLeave * hi StatusLine ctermbg='.a:1
         exe 'autocmd InsertEnter * hi StatusLine ctermbg='.a:2
      endif
   augroup END
endfunction

" Extensions
" Even more Fancy for terminal vim
if &t_Co == 256 && !has('gui_running')
    highlight StatusLine ctermbg=82 ctermfg=16 cterm=bold
    highlight StatusLineNC ctermbg=92 ctermfg=16 cterm=None
    highlight TablineSel ctermbg=82 ctermfg=16 cterm=bold
    highlight Tabline ctermbg=92 ctermfg=16 cterm=None
    if has("autocmd")
       augroup vividwolf
          au!
          autocmd ColorScheme * call s:setup_statusline()
          autocmd ColorScheme vividwolf call s:setup_statusline(82,208)
       augroup END
   endif
endif

" {{{ Filetype specific
" {{{ java
hi link javaClassDecl Statement
hi link javaScopeDecl Identifier
hi link javaLangObject Identifier
hi link javaParen Special
highlight! javaParen1 ctermfg=Yellow
highlight! javaParen2 ctermfg=Red
" }}}
" todo.txt {{{ "
" hi link TodoPriorityA Statement
" hi link TodoPriorityB Identifier
" hi link TodoPriorityC Constant
hi link TodoContext Special
hi link TodoProject Type
fun! s:rainbow(groups, start, ...) abort
   "first opt arg: interval
   if a:0 >= 1
      let inc = a:1
   else
      let inc = (&t_Co - a:start) / len(a:groups)
   endif
   let cval = a:start
   for group in a:groups
      exe "hi ".group." ctermfg=".cval
      let cval = cval + inc
   endfor
endf
let s:letters=["A","B","C","D","E","F","G","H","I","J","K","L","M","O","P","Q","R","S","T","U","V","W","X","Y","Z"]
let priority_groups = map(s:letters, "'TodoPriority'.v:val")
call s:rainbow(priority_groups, 1)

" }}} todo.txt "
" pandoc {{{ "
highlight clear pandocTitleBlock
highlight link pandocTitleBlock PreProc
" }}} pandoc "
" tex {{{ "
highlight link texBeginEndName Identifier
highlight link PreCondit PreProc
highlight link texMath PreProc
" highlight link texRefZone

" }}} tex "
" }}}
