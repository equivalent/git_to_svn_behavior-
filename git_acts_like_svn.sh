#!/bin/bash


#bash script (by eq8) for getting this functionality: http://stackoverflow.com/questions/928646/how-do-i-tell-git-to-always-select-my-local-version-for-conflicted-merges-on-a-sp

if [ "$(id -u)" != "0" ]; then
  echo "This script must be run as root (use sudo !)" 1>&2
  exit 1
fi
  
echo "===========================================================
This directrory will act as svn
that means, when git conflict accure between 2 branches,
changes in your branch will owerite version you are merging

"


if [ ! -f /usr/bin/gitAttributesKeepMine.sh ]; then
 echo "creating /usr/bin/gitAttributesKeepMine.sh"

  touch /usr/bin/gitAttributesKeepMine.sh
  chmod a+x /usr/bin/gitAttributesKeepMine.sh
  which gitAttributesKeepMine.sh

  echo "# I want to keep MY version when there is a conflict
# Nothing to do: %A (the second parameter) already contains my version
# Just indicate the merge has been successfully "resolved" with the exit status
#
#uncoment next line if you wan't to keep their changes
#cp -f $3 $2
exit 0" >> /usr/bin/gitAttributesKeepMine.sh


fi


function is_a_git_repositary {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'
}



if [ -z $(is_a_git_repositary)  ]; then
  echo "Error: not a git repository! 
  try git init + git commit -a 
  "

  exit
fi

echo '* merge=keepMine' > .gitattributes
git config merge.keepMine.name "always keep mine during merge"
git config merge.keepMine.driver "gitAttributesKeepMine %O %A %B"

#if you want only merge functionality coment next  3 lines
echo '* rebase=keepMine' >> .gitattributes
git config rebase.keepMine.name "always keep mine during rebase"
git config rebase.keepMine.driver "gitAttributesKeepMine %O %A %B"

echo 'done'
