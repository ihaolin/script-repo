# git branch kb

* check out remote branch from git server
<pre>
	** you maybe do this before **
	git remote update
	git fetch 
	git checkout -b local_branch origin/remote_branch
</pre>
* show all local and remote branches
<pre>
	git remote show origin
</pre>
* merge current branch with other branch
<pre>
	git merge other_branch
</pre>
* delete branch
<pre>
	git branch -d branch_name 
</pre>
* push current branch to remote
<pre>
	git push origin
</pre>
* delete current branch from remote
<pre>
	git push origin :
</pre>
* rename branch:
<pre>
	git branch -m [old_branch] new_branch
</pre>