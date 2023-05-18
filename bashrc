;= @echo off
;= rem Call DOSKEY and use this file as the macrofile
;= %SystemRoot%\system32\doskey /listsize=1000 /macrofile=%0%
;= rem In batch mode, jump to the end of the file
;= goto:eof
;= Add aliases below here

e.=explorer .
gl=git log --oneline --all --graph --decorate  $*
ls=ls --show-control-chars -F --color $*
pwd=cd
clear=cls
history=cat "%CMDER_ROOT%\config\.history"
aliase=vim "%CMDER_ROOT%\config\user_aliases.cmd"
unalias=alias /d $1
vi=vim $*
vf= cd /d "C:\Users\ethan.fischer\vimfiles"
cmderr=cd /d "%CMDER_ROOT%"
ics=cd "C:\Users\ethan.fischer\GitProjects\ICS"
smx=cd "C:\Users\ethan.fischer\GitProjects\ICS\InContext.SMX2"
smxw=cd "C:\Users\ethan.fischer\GitProjects\ICS\InContext.SMX2.Webservices"
smxa=cd "C:\Users\ethan.fischer\GitProjects\ICS\InContext.ShopperMXAnywhere"
em=cd "C:\Users\ethan.fischer\GitProjects\ICS\InContext.Everyman\trunk"
cleanem=for /F %d in ('dir /AD /B "bin" "obj" /S') do rmdir /S /Q %d
cp=cd "C:\Users\ethan.fischer\GitProjects\ICS\InContext.ClientPortal"
sg=cd /d "D:\GitProjects\SurrealGame2019"
sgvrtk=cd /d "D:\GitProjects\Surreal Game\surreal_game\Assets\VRTK"
tt=cd /d "D:\GitProjects\TiffinTown"
cl=clear
nuke=git reset --hard $t git clean -fd
nukes=git clean -xfd $t git submodule foreach --recursive $t git clean -xfd $t git reset --hard $t git submodule foreach --recursive $t git reset --hard $t git submodule update --init --recursive
branch=git fetch --prune $t git remote remove origin-http $t git branch -a
vs=ls *.sln | xargs -0 start "" 
prunelocal=git branch -vv | grep 'origin/.*: gone]' | awk '{ print $1 }'

;= GIT COMMANDS

ch=git checkout $*
chm=git checkout master
g-=git checkout -
a=git add $*
ps=git push
pl=git pull
c=git commit
l=git log
lp=git log --pretty=oneline
st=git stash
sta=git add . $t git stash
stp=git stash pop
status=git status
m=git merge $*
mm=git checkout master $t git pull $t git checkout - $t git merge master
cm=git checkout master $t git pull $t git merge - --no-commit --no-ff
pss=git push -u origin HEAD
~=cd /d ^%USERPROFILE^%
