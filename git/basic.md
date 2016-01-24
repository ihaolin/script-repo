# Basic

```bash
# 查看分支
git branch

# 创建分支
git branch <branch_name>

# 切换分支
git checkout <branch_name>

# 创建并切换分支
git checkout -b <branch_name>

# 合并当前工作分支与其他分支
git merge <other_branch_name>

# 删除分支
git branch -d <branch_name>

# 查看当前分支已经合并了哪些分支
git branch --merge

# 将远程仓库分支数据同步到本地对应分支上
git fetch <远程仓库名> <分支名>

# 把另一个服务器加为远程仓库
git remote add <server_name> <git_url>

# 更新仓库源
git remote set-url origin <git_url>

# 推送本地分支
git push (远程仓库名) (分支名)

# 跟踪远程分支
git checkout --track (远程仓库名)/(分支名)

# 删除服务器分支
git push [远程名] :[分支名]

# 衍合分支，将当前分支以branch_name为基础进行补丁，再合并。
git rebase <branch_name>



```