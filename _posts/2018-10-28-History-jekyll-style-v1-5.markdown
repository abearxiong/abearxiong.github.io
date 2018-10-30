---
layout: post
title: Jekyll Blog Style v1 final
date:   2018-10-28 12:00:57 +8000
categories: jekyll
tags: blog
comments: true
#description: g
---
对于Jekyll blog的设计方案。
(1）要的文章列表页面（2）要的其他信息页面（3）要的文章页面

[x] 所有文章列表
    - [x] 标签
    - [x] 分类
    - [x] 内容
    - [x] 上下一页
    - [ ] RSS
    - [ ] 样式
[ ] 文章
    - [ ] 标签
    - [ ] 分类
    - [x] 评论
    - [ ] 最新文章或关联文章
    - [ ] 文字统计和访问统计
    - [ ] 样式
[ ] 其他页面的信息
    - [ ] 标签页面
        - [ ] 具体标签
        - [ ] 表格分类
    - [ ] 分类页面
    - [ ] 归档页面
    - [ ] 个人信息页面
    - [ ] Jekyll Blog 历程页面
    - [ ] 导航页站点地图
[ ] 插件
    - [ ] 百度分析
    - [ ] Google分析
    - [x] disqus（fooleap有关于墙内访问的[github](https://github.com/fooleap/disqus-php-api "disqus-api")）
[ ] 其他
    - [x] 图床[cloudinary](https://cloudinary.com)

还行的Jekyll Blog
#### 一级推荐
2. [fooleap][bg2]
3. [mytrix][bg3]
4. [leiminnet][bg4]

#### 二级推荐
1. [liberize][bg1]
<!-- more -->
对于这个三个思考，首先想到的是文章。
1. 需要有标签和分类，标签跳转，显示相应的标签的内容。
2. 需要可以设置的评论,disqus。直接添加js代码即可
3. 需要有最新文章和关联文章的显示。
4. 文字数量统计和访问统计，访问统计可以用百度分析引入和Google分析引入。


<script src="https://gist.github.com/abearxiong/959575ccea40cc6d166418133e346339.js"></script>
<br/>
{% gist c08ee0f2726fd0e3909d test.md %}
{% gist 959575ccea40cc6d166418133e346339 dd.py %}
编辑历程：
    2018-10-28 初稿
[bg1]: http://liberize.github.io/ "纯净,白"
[bg2]: https://blog.fooleap.org/ "纯净，干脆/80"
[bg3]: https://mytrix.in/ "日语一点点，纯净"
[bg4]: http://leiminnet.cn "有一些友联可以卡"
[bg5]: https://dayday.plus
