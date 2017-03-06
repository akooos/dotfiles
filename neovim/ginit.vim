if exists('g:GuiLoaded')
  Guifont! Hack:h10
endif
set guifont="Hack:h10,Fixed:h10"
set guifontwide="Hack:h10,Noto Emoji:h8,Symbola:h8"
if has("gui_running")
  inoremap <silent><expr><C-Space> deoplete#mappings#manual_complete()
else
  inoremap <silent><expr><C-@> deoplete#mappings#manual_complete()
endif
