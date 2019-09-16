---
layout: post
title: gist在jekyll的利用方式 
date: 2019-06-30 00:01:00 +0800 
categories: ruby 
tags: ["ruby", "rake", "gist", "jekyll", "blog"]
comments: false
description: gist每次在利用的时候，我不知道哪里使用了gist，然后同样不知道某一天在gist中删除是否会影响到jekyll博客的内容，所以我就需要一个位置进行存放gist的记录，什么时候引用，引用的位置在哪，那么久很容易找到位置，找到引入了多少。可以便捷对gist进行修改，而不是害怕修改删除了gist会对博客造成影响。
---
## gist对于整个博客是具有利用性的

gist是一个代码片段的网站工具，可以在gist存放代码，然后在jekyll实现把代码显示，只是多了一层引入，但是功能分层很用利用性。所以我很是喜欢gist的服务，但是gist有时候会是被墙住的，感觉无语咯。

## gist在jekyll博客中引入的方法

1. 可以用js脚本引入，在写下gist代码的时候，可以利用gist的分享，可以看到gist的script的脚步，复制粘贴，在自己的静态博客引入即可，会为html样式显示
2. 使用jekyll-gist插件，使用`{% raw %} {%  gist 仓库名 文件名%} {% endraw %}`即可

## gist在jekyll博客中管理的方案

一般情况下，gist是直接粘贴到某个博客内容的，注意到有问题，粘贴后，如果不打开，是不知道其中的内容是否包含gist的，其二，不知道具体的gist的内容可能是什么，其三，某一个对gist进行整理，会导致不知道自己能不能删，不知道自己是否已经引入了那个gist内容。

所以进行管理，专门一个gist文件夹进行添加内容，使用rake方式，添加gist，添加描述，添加具体某一个时间添加的这个gist，也可以添加放置的位置，进行通过粘贴复制，直接引入到具体的内容中，是很方便的，容易管理的，那么对于我来说，那样的保存方式就很安逸，舒适。

## gist实现代码rake

输入：`rake gist['粘贴的脚本','文件名','描述','标签']``

生成表格： 脚本描述，脚本仓库，脚本具体的某个文件名，标签，创建时间，复制的代码，使用的位置

保存的仍旧是markdown的文件，有一个url根据时间`/gist/年/月`。

### 流程

根据时间判断，拥有那个文件则在末尾新添，不具有那个文件则新建一个文件。

#### 存在的时候
在最后一行添加新的内容

{% raw %} |脚本描述|仓库|文件名|标签|创建时间|需要复制的代码| {% endraw %}

#### 新建类型

类似下方的头：

```markdown
---
layout: default
title: 所有的pages页面
date: 2019-06-15 11:30:07 +0800 
description: 关于页面内容中的所有站点统计
permalink: /site/pages
---
```

还有表格的头：

`{% raw %} |脚本描述|仓库|文件名|标签|创建时间|需要复制的代码| {% endraw %}`

然后添加内容


### 代码

Ruby的代码内容，非rakefile

```Ruby
#!/usr/bin/ruby
# -*- coding: UTF-8 -*-
def have_file(path="gists")
    unless File.exist?(path)
        puts "创建gists"
        Dir.mkdir(path)
    end
end
def gist(gist, name, title="gists", description="保存gists", tags="null")
    time = Time.new #Get new time
    newfile = time.strftime("gists/%Y-%m-gists.md")
    inputContent = ''
    copy = "{% raw %}   {% gist #{gist} name %}   {% endraw %}"
    if File.exist?(newfile)
        inputContent = "|#{title}|#{gist}\t|#{name}\t|#{tags}\t|#{time.inspect}\t|#{description}\t\t|#{copy}|\n"
        File.open(newfile, "a+") do |aFile|
            aFile.write(inputContent)
        end
    else 
        header = "---\nlayout: default \ntitle:'gist管理'\ndate: #{time.inspect} \n#{description}\npermalink: /gists/#{time.year}/#{time.month}\n---\n"
        head = "|题目|仓库|文件名|标签|创建时间|脚本描述|需要复制的代码|\n|---|---|---|---|---|---|\n"
        inputContent = "|#{title}|#{gist}\t|#{name}\t|#{tags}\t|#{time.inspect}\t|#{description}\t\t|#{copy}|\n"
        File.open(newfile, "w+") do | aFile |
            aFile.write(header)
            aFile.write(head)
            aFile.write(inputContent)
        end  
    end
    puts "gist库: #{gist},文件名： #{name}，描述：#{description}，标签：#{tags} "
    puts "创建时间，#{Time.new}"
end

# gist("710b731b800e710f343c3f611a8fe60d", "src_read.py", "test3333", "tag1tag2")
have_file("gists2")
```