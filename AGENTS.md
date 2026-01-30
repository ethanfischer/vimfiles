# AGENTS.md

Personal Vim configuration repository with Windows-centric setup and custom Unity ShaderLab support.

## Essential Commands

### Vim Operations
```vim
:source $HOME/vimfiles/vimrc     " Reload configuration
:PlugInstall                      " Install plugins
:PlugUpdate                       " Update plugins
:PlugClean                        " Remove unused plugins
```

### Git Workflow (Custom Aliases)
```bash
mm      " Merge master into current branch
chm     # Checkout master
nuke    # Reset hard and clean untracked files
sta     # Stash all changes
stp     # Stash pop
pss     # Push current branch to origin
src     # Reload PowerShell profile
vim     # Launch Neovim
cc      # Open OpenCode
ccr     # Open OpenCode with -c flag
```
**Note:** Adding new aliases requires updating `Microsoft.PowerShell_profile.ps1`.

### Key Navigation
```vim
<leader>rc    " Open vimrc in new tab
<leader>grc   " Open gvimrc in new tab
<c-p>         " Fuzzy find files (FZF)
<c-f>         " Search in files
```

## Repository Structure

- `vimrc` - Core Vim configuration
- `gvimrc` - Plugin configurations and GUI settings
- `Microsoft.PowerShell_profile.ps1` - PowerShell profile
- `syntax/shaderlab.vim` - Unity ShaderLab syntax highlighting
- `ftdetect/shaderlab.vim` - File type detection for shaders
- `indent/shaderlab.vim` - Indentation rules for shaders

## Code Style Guidelines

### VimScript Conventions
- **Indentation:** 4 spaces, no tabs
- **Line endings:** Unix-style (\n)
- **Comments:** Use double quotes (")
- **Naming:** `kebab-case` for files, `snake_case` for variables/functions
- **Strings:** Single quotes for literals, double quotes for strings with expansion

### Plugin Management
- Add plugins to `gvimrc` (not `vimrc`)
- Use format: `Plug 'author/plugin-name'`
- Group plugins by functionality with comments
- Place plugin configurations immediately after declarations

### Key Mapping Conventions
- Leader key is space (`let mapleader = " "`)
- Use `<leader>` prefix for custom commands
- Common patterns: `<leader>c` (commands), `<leader>f` (files), `<leader>g` (git)

## Cross-Platform Considerations

- Use `$HOME` instead of `~` for consistency
- Forward slashes in VimScript, backslashes in PowerShell
- Plugin directory: `~/vimfiles/plugged/`


## Unity ShaderLab Support

Custom language support for Unity ShaderLab:
- File patterns: `*.shader`, `*.cginc`
- Syntax highlighting, file detection, and indentation rules
- When adding new language support, create files in `syntax/`, `ftdetect/`, `indent/` directories

## Testing Configuration

1. Test changes in clean Vim: `vim -u $HOME/vimfiles/vimrc`
2. Verify plugin loading: `:scriptnames`
3. Check key mappings: `:map <leader>rc`
4. Validate syntax highlighting with test files

## Neovim Integration

Neovim is configured to use this vimfiles setup via `C:\Users\ethan\AppData\Local\nvim\init.vim`:
```vim
set runtimepath^=C:\Users\ethan\repos\vimfiles
source C:\Users\ethan\repos\vimfiles
```
Changes to vimfiles will automatically apply to both Vim and Neovim.