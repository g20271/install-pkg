#!/bin/bash
source /home/admin/.nix-profile/etc/profile.d/nix.sh
nix-env -iA nixpkgs.neovim
nix-env -iA nixpkgs.clang
nix-env -iA nixpkgs.clang-tools
nix-env -iA nixpkgs.deno
#nix-env -iA nixpkgs.cargo

#curl -fsSL https://deno.land/x/install/install.sh | sh

# export DENO_INSTALL="/home/$HOME/.deno"
# export PATH="$DENO_INSTALL/bin:$PATH"

# grep -q "export DENO_INSTALL="/home/$HOME/.deno" #For deno" $HOME/.bashrc
# if [ $? -eq 1 ] ; then
#    echo "export DENO_INSTALL="/home/$HOME/.deno" #For deno" >> $HOME/.bashrc
# fi

# grep -q "export PATH="$DENO_INSTALL/bin:$PATH" #For deno" $HOME/.bashrc
# if [ $? -eq 1 ] ; then
#    echo "export PATH="$DENO_INSTALL/bin:$PATH" #For deno" >> $HOME/.bashrc
# fi
# echo "denoのインストールが完了しました"

mkdir -p $HOME/.config/nvim/

curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
sh ./installer.sh ~/.cache/dein

if [ -e $HOME/.config/nvim/init.vim ]; then
  mv $HOME/.config/nvim/init.vim $HOME/.config/nvim/init.vim_
fi

grep -q 'export LANG=ja_JP.UTF-8 ; export LC_ALL= ; export LC_CTYPE= #For neovim' $HOME/.bashrc
if [ $? -eq 1 ] ; then
   echo 'export LANG=ja_JP.UTF-8 ; export LC_ALL= ; export LC_CTYPE= #For neovim' >> $HOME/.bashrc
fi

cat << 'EOS' > $HOME/.config/nvim/init.vim
set tabstop=4
set shiftwidth=4
set expandtab
set nu
set cindent
set mouse=a
set title

if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=/home/admin/.cache/dein/repos/github.com/Shougo/dein.vim

" Required:
call dein#begin('/home/admin/.cache/dein')

" Let dein manage dein
" Required:
call dein#add('/home/admin/.cache/dein/repos/github.com/Shougo/dein.vim')

call dein#add('vim-denops/denops.vim')

call dein#add('Shougo/ddc.vim')
call dein#add('Shougo/ddc-matcher_head')
call dein#add('Shougo/ddc-sorter_rank')

call dein#add('prabirshrestha/vim-lsp')
call dein#add('mattn/vim-lsp-settings')
call dein#add('shun/ddc-vim-lsp')

call dein#add('itchyny/lightline.vim')
call dein#add('cocopon/iceberg.vim')

" Add or remove your plugins here like this:
"call dein#add('Shougo/neosnippet.vim')
"call dein#add('Shougo/neosnippet-snippets')

" Required:
call dein#end()

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif


" Customize global settings
" Use around source.
" https://github.com/Shougo/ddc-around
call ddc#custom#patch_global('sources', ['around'])

" Use matcher_head and sorter_rank.
" https://github.com/Shougo/ddc-matcher_head
" https://github.com/Shougo/ddc-sorter_rank
call ddc#custom#patch_global('sourceOptions', {
      \ '_': {
      \   'matchers': ['matcher_head'],
      \   'sorters': ['sorter_rank']},
      \ })

" Change source options
call ddc#custom#patch_global('sourceOptions', {
      \ 'around': {'mark': 'A'},
      \ })
call ddc#custom#patch_global('sourceParams', {
      \ 'around': {'maxSize': 500},
      \ })

call ddc#custom#patch_global('sources', ['vim-lsp'])
    call ddc#custom#patch_global('sourceOptions', {
        \ 'vim-lsp': {
        \   'matchers': ['matcher_head'],
        \ 'minAutoCompleteLength':1},
        \   'mark': 'lsp',
        \ },
        \ })

" Customize settings on a filetype
"call ddc#custom#patch_filetype(['c', 'cpp'], 'sources', ['around', 'clangd'])
"call ddc#custom#patch_filetype(['c', 'cpp'], 'sourceOptions', {
"      \ 'clangd': {'mark': 'C'},
"      \ })
"call ddc#custom#patch_filetype('markdown', 'sourceParams', {
"      \ 'around': {'maxSize': 100},
"      \ })

" Mappings

" <TAB>: completion.
inoremap <silent><expr> <TAB>
\ pumvisible() ? '<C-n>' :
\ (col('.') <= 1 <Bar><Bar> getline('.')[col('.') - 2] =~# '\s') ?
\ '<TAB>' : ddc#map#manual_complete()

" <S-TAB>: completion back.
inoremap <expr><S-TAB>  pumvisible() ? '<C-p>' : '<C-h>'

" Use ddc.
call ddc#enable()

colorscheme iceberg

EOS
