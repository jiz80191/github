# 第一天

1. 今天终于成功的配置了github，已经从web、vscode及GitHub Desktop端成功的联接github。
2. 已经之间的测试项目及文件全部删除，重新建库，已经成功，现在的编辑是在VScode上进行的。
3. vscode突然提示git服务出现问题，让重新下载git安装，这个需要找一下原因。
4. 目前原因没找到，不过重新安装git就可以用了。
5. vscode安装Office Viewer插件后，编辑就方便多了，不用考虑换行等问题了。

# 测试

1.今天win10重置，需要重新配置，出现了一堆问题，vscode不能直接git

2.发现一个问题，我将git安装到D:\git下，然后vscode找不到git路径，如下设置就正常了

```
在VS Code中，点击顶部菜单的“文件”>“首选项”>“设置”。
在设置界面的搜索框中，搜索“git.path”。
确保“git.path”设置为正确的Git可执行文件的路径。
例如，在Windows上，默认路径可能是“D:\\Git\\bin\\git.exe”。
如果“git.path”设置正确，尝试重新启动VS Code并查看Git是否恢复正常。
```
