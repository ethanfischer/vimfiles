Set-Location C:\Users\ethan\repos

Set-Alias wp WeirdPlace
Set-Alias e. ExplorerHere
#Set-Alias gl GLFunction
#Set-Alias vf VFFunction
Set-Alias cmderr CMDERRFunction
Set-Alias cleanem CLEANEMFunction
Set-Alias CLFunction CLFunction
Set-Alias nuke NUKEFunction
Set-Alias nukes NUKESFunction
Set-Alias branch BRANCHFunction
Set-Alias vs VSFunction
Set-Alias prunelocal PRUNELOCALFunction
Set-Alias ch CHFunction
Set-Alias ch- CHDashFunction
Set-Alias chm CHMFunction
Set-Alias wchm WCHMFunction
Set-Alias g- G-Function
Set-Alias a AFunction
Set-Alias -Name ps -Value PSFunction -Option AllScope
Set-Alias pl PLFunction
Set-Alias C CFunction
Set-Alias L LFunction
Set-Alias -Name lp -Value LPFunction -Option AllScope
Set-Alias st STFunction
Set-Alias sta STAFunction
Set-Alias stp STPFunction
Set-Alias status STATUSFunction
Set-Alias M MFunction
Set-Alias mm MMFunction
Set-Alias wmm WMMFunction
Set-Alias cm CMFunction
Set-Alias pss PSSFunction
Set-Alias pr CreatePR
Set-Alias lg LazyGitFunction
Set-Alias src SRCFunction
Set-Alias vim VimFunction
Set-Alias alie AlieFunction
Set-Alias cc CCFunction
Set-Alias ccr CCRFunction
Set-Alias ccc CCCFunction
Set-Alias gpt "python3 -m EdgeGPT --cookie-file C:\Users\ethan.fischer\AppData\Local\Microsoft\Edge\cookies.json --rich"
Set-Alias azbuild "az pipelines build queue --definition-name InContext.Identity --open"
Set-Alias spd ScratchPadFunction

function WeirdPlace {
    cd ~/repos/weirdplace2
}
function ExplorerHere {
    explorer .
}
function .. {
    Set-Location ..
}
function ... {
    Set-Location ../..
}
function GLFunction {
    git log --oneline --all --graph --decorate  $*
}
function VFFunction {
    cd /d "C:\Users\ethan.fischer\vimfiles"
}
function CMDERRFunction {
    cd /d "%CMDER_ROOT%"
}
function CLEANEMFunction {
    #for /F %d in ('dir /AD /B "bin" "obj" /S') do rmdir /S /Q %d
}
function NUKEFunction {
    git reset --hard 
    git clean -fd
}
function NUKESFunction {
    git clean -xfd $t git submodule foreach --recursive $t git clean -xfd $t git reset --hard $t git submodule foreach --recursive $t git reset --hard $t git submodule update --init --recursive
}
function BRANCHFunction {
    git fetch --prune $t git remote remove origin-http $t git branch -A
}
function VSFunction {
    Get-ChildItem *.sln | Invoke-Item
}
function PRUNELOCALFunction {
    git branch -vv | grep 'origin/.*: gone]' | awk '{ print $1 }'
}
function CHFunction {
    git checkout $args
}
function CHDashFunction {
    git checkout -
}
function CHMFunction {
    git checkout master
}
function WCHMFunction {
    git checkout main
}
function G-Function {
    git checkout -
}
function AFunction {
    git add *
}
function PSFunction {
    git push
}
function PLFunction {
    git pull
}
function CFunction {
    git commit *
}
function LFunction {
    git log
}
function LPFunction {
    git log --pretty=oneline
}
function STFunction {
    git stash
}
function STAFunction {
    git add . 
    git stash
}
function STPFunction {
    git stash pop
}
function STATUSFunction {
    git status
}
function MFunction {
    git merge $*
}
function WMMFunction {
    git checkout main 
    git pull 
    git checkout - 
    git merge main 
}
function MMFunction {
    git checkout master 
    git pull 
    git checkout - 
    git merge master
}
function CMFunction {
    git checkout master $t git pull $t git merge - --no-commit --no-ff
}
function PSSFunction {
    git push -u origin HEAD
}
function CreatePR {
    az repos pr create --open
}

function LazyGitFunction {
    lazygit
}

function SRCFunction {
    . "C:/Users/ethan/repos/vimfiles/Microsoft.PowerShell_profile.ps1"
}

function VimFunction {
    nvim $args
}

function AlieFunction {
    nvim C:\Users\ethan\repos\vimfiles\Microsoft.PowerShell_profile.ps1
}

function CCFunction {
    claude $args
}

function CCRFunction {
    claude --resume
    #~\.claude\claude-sessions.ps1
}

function CCCFunction {
    claude --continue
}
function ScratchPadFunction {
    vim ~/scratchpad.txt
}

# zsh-like shell behavior for PowerShell:
# - syntax highlighting
# - autosuggestions
# - vi mode (+ cursor shape changes)
if (-not (Get-Command Set-PSReadLineOption -ErrorAction SilentlyContinue)) {
    if (Get-Module -ListAvailable -Name PSReadLine) {
        try {
            Import-Module PSReadLine -ErrorAction Stop
        } catch {
            # Continue loading profile even if PSReadLine import conflicts.
        }
    }
}

if (Get-Command Set-PSReadLineOption -ErrorAction SilentlyContinue) {

    Set-PSReadLineOption -EditMode Vi
    Set-PSReadLineOption -ViModeIndicator Cursor
    Set-PSReadLineOption -HistorySearchCursorMovesToEnd

    $psrlOptionParams = (Get-Command Set-PSReadLineOption).Parameters.Keys
    if ($psrlOptionParams -contains 'PredictionSource') {
        try {
            Set-PSReadLineOption -PredictionSource History
        } catch {
            # Older/non-VT consoles can reject prediction mode.
        }
    }
    if ($psrlOptionParams -contains 'PredictionViewStyle') {
        try {
            Set-PSReadLineOption -PredictionViewStyle InlineView
        } catch {
            # Ignore if prediction is unavailable in the current host.
        }
    }

    Set-PSReadLineOption -Colors @{
        Command   = 'Yellow'
        Number    = 'White'
        String    = 'DarkCyan'
        Operator  = 'Gray'
        Variable  = 'Green'
        Parameter = 'Cyan'
        Type      = 'DarkYellow'
        Comment   = 'DarkGray'
    }

    $psrlKeyHandlerFns = (Get-Command Set-PSReadLineKeyHandler).Parameters['Function'].Attributes.ValidValues
    if ($psrlKeyHandlerFns -contains 'AcceptSuggestion') {
        # Match zsh Shift+Tab autosuggestion accept behavior on newer PSReadLine.
        Set-PSReadLineKeyHandler -Chord 'Shift+Tab' -Function AcceptSuggestion
    }
    Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
    Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward
    Set-PSReadLineKeyHandler -Key Enter -ScriptBlock {
        param($key, $arg)

        $line = $null
        $cursor = $null
        [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState([ref]$line, [ref]$cursor)
        $candidate = $line.Trim()

        if ($candidate) {
            $isQuoted = (($candidate.StartsWith("'") -and $candidate.EndsWith("'")) -or ($candidate.StartsWith('"') -and $candidate.EndsWith('"')))
            if (($candidate -notmatch '\s') -or $isQuoted) {
                $pathCandidate = if ($isQuoted) { $candidate.Substring(1, $candidate.Length - 2) } else { $candidate }
                if (Test-Path -LiteralPath $pathCandidate -PathType Container) {
                    $escapedPath = $pathCandidate.Replace("'", "''")
                    [Microsoft.PowerShell.PSConsoleReadLine]::RevertLine()
                    [Microsoft.PowerShell.PSConsoleReadLine]::Insert("Set-Location -LiteralPath '$escapedPath'")
                    [Microsoft.PowerShell.PSConsoleReadLine]::AcceptLine()
                    return
                }
            }
        }

        [Microsoft.PowerShell.PSConsoleReadLine]::AcceptLine()
    }
}

# Git prompt/status enhancements.
if (Get-Module -ListAvailable -Name posh-git) {
    Import-Module posh-git -ErrorAction SilentlyContinue
}

# Prompt theme.
if (Get-Command oh-my-posh -ErrorAction SilentlyContinue) {
    $ompTheme = $null
    if ($env:POSH_THEMES_PATH) {
        $candidate = Join-Path $env:POSH_THEMES_PATH 'hotstick.minimal.omp.json'
        if (Test-Path $candidate) {
            $ompTheme = $candidate
        }
    }
    if (-not $ompTheme) {
        $candidate = Join-Path $env:LOCALAPPDATA 'Programs\oh-my-posh\themes\hotstick.minimal.omp.json'
        if (Test-Path $candidate) {
            $ompTheme = $candidate
        }
    }
    try {
        if ($ompTheme) {
            oh-my-posh init pwsh --config $ompTheme 2>$null | Invoke-Expression
        } else {
            oh-my-posh init pwsh 2>$null | Invoke-Expression
        }
    } catch {
        # Keep profile load resilient if oh-my-posh cannot write temp init files.
    }
}
