---
layout: post
title:  History about Jekyll style(1)
date:   2018-10-20 12:00:00 +0800
categories: jekyll
tags: blog
comments: true
description: 想法
---
 对于Jekyll blog的设计方案。设计Jekyll Style.
 ![风格](https://res.cloudinary.com/xiongxiao/image/upload/v1540018987/github/images/jekyll-themesV1.png)
Jekyll最基本的主题自己看了很多，然而我更想要自己设计自己风格一个静态github page页面。<!-- more -->
1. 关于内容摘要问题
{% highlight html %}
关于RSS的
<p class="rss-subscribe">subscribe <a href="{{ "/feed.xml" | relative_url }}">via RSS</a></p>
关于Jekyll摘要设置-- 内容区<!-- more --> 
 同时_config.yml设置
 excerpt_separator: <!--excerpt-->  #这里可以定义自己的摘要分割符
 POST内容区：<p>{{ post.excerpt }}</p>
{% endhighlight %}

2. layout中的文件，default.html,home.html,post.html,page.html等等

default.html 是设置默认页面
post.html 是文章
home.html 主要是pages分页显示页面
page.html 是单个的文章显示风格

3. 使用bootrap样式，使用row，col分割窗口
4. 发现一个问题，没有解决?
分成连个row行，一个row行滚动，如何使得另一个行不滚动，进行固定状态。
