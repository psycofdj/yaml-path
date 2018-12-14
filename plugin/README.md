# README

## Installation

Using a VIm plugin manager such as:
* [https://github.com/tpope/vim-pathogen](Pathogen)
* [https://github.com/VundleVim/Vundle.vim](Vundle)

Manually:
```console
install -m 0644 -D yaml-path.vim ~/.vim/plugin/
```

## Configuration

In your `~/.vimrc`:
- `g:yamlpath_sep`: change default separator (default: `/`)
- `g:yamlpath_auto`: enable automatic call on cursor move on YAML files (default: `0`)
- to call the tool with a keystroke such as F12, add to you `~/.vimrc`:
```
nnoremap <F12> :Yamlpath<CR>
```

## Other

To call the tool with a custom separator once (in command mode):
`:Yamlpath "."`
