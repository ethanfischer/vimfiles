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
}

function CCCFunction {
    claude --continue
}
function ScratchPadFunction {
    vim ~/scratchpad.txt
}

#Import-Module posh-git
#oh-my-posh init pwsh --config C:\Users\ethan.fischer\AppData\Local\Programs\oh-my-posh\themes/hotstick.minimal.omp.json | Invoke-Expression
#Import-Module oh-my-posh
#Set-PoshPrompt -Theme hotstick.minimal
