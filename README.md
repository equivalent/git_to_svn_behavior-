to reference of this problem: http://stackoverflow.com/questions/928646/how-do-i-tell-git-to-always-select-my-local-version-for-conflicted-merges-on-a-sp

This will some git folder to act as svn durring merging conflicts. That means when you do git merge or git rebase and conflict accrues, your changes in your branch will overwrite changes you are merging/rebasing from
(similar functionality goes to git pull)

>       cd ~/myapp/public/xcf/
>       sudo ~/path_where_you_cloned_this_repo/git_acts_like_svn.sh
