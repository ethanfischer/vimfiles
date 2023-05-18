Set-Location C:\Users\ethan.fischer\GitProjects\ICS

Set-Alias ics GoToICS
Set-Alias e. ExplorerHere
#Set-Alias gl GLFunction
#Set-Alias vf VFFunction
Set-Alias cmderr CMDERRFunction
Set-Alias smx SMXFunction
Set-Alias smxw SMXWFunction
Set-Alias smxa SMXAFunction
Set-Alias smxg SMXGFunction
Set-Alias em EMFunction
Set-Alias cleanem CLEANEMFunction
Set-Alias -Name cportal -Value CPFunction -Option AllScope
Set-Alias sg SGFunction
Set-Alias sgvrtk SGVRTKFunction
Set-Alias tt TTFunction
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
Set-Alias gpt "python3 -m EdgeGPT --cookie-file C:\Users\ethan.fischer\AppData\Local\Microsoft\Edge\cookies.json --rich"
Set-Alias azbuild "az pipelines build queue --definition-name InContext.Identity --open"

function GoToICS {
    cd C:\Users\ethan.fischer\GitProjects\ICS
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
function SMXFunction {
    cd "C:\Users\ethan.fischer\GitProjects\ICS\InContext.SMX2"
}
function SMXWFunction {
    cd "C:\Users\ethan.fischer\GitProjects\ICS\InContext.SMX2.Webservices"
}
function SMXAFunction {
    cd "C:\Users\ethan.fischer\GitProjects\ICS\InContext.ShopperMXAnywhere"
}
function SMXGFunction {
    cd "C:\Users\ethan.fischer\GitProjects\ICS\InContext.SMXGo"
}
function EMFunction {
    cd "C:\Users\ethan.fischer\GitProjects\ICS\InContext.Everyman\trunk"
}
function CLEANEMFunction {
    #for /F %d in ('dir /AD /B "bin" "obj" /S') do rmdir /S /Q %d
}
function CPFunction {
    cd "C:\Users\ethan.fischer\GitProjects\ICS\InContext.ClientPortal"
}
function SGFunction {
    cd /d "D:\GitProjects\SurrealGame2019"
}
function SGVRTKFunction {
    cd /d "D:\GitProjects\Surreal Game\surreal_game\Assets\VRTK"
}
function TTFunction {
    cd /d "D:\GitProjects\TiffinTown"
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

Import-Module posh-git
oh-my-posh init pwsh --config C:\Users\ethan.fischer\AppData\Local\Programs\oh-my-posh\themes/hotstick.minimal.omp.json | Invoke-Expression
#Import-Module oh-my-posh
#Set-PoshPrompt -Theme hotstick.minimal
