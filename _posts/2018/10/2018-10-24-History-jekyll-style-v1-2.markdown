---
layout: post
title:  History about Jekyll style(2)
date:   2018-10-24 12:00:00 +0800
categories: jekyll
tags: blog
comments: true
description: "过去的v2想法"
---
 对于Jekyll blog的设计方案。
1. 继续探讨昨天的问题，怎么分两栏，分别滚动。 （1）打算使用overflow:scroll尝试，失败，还是一起滚动。（2）感觉是因为自己没有写他的长度，设定posts页面长度试试：解决
2. 关于多适应。想尝试使用Bootstrap里面的less，单独取出那块，然后出现了bug，一直调试。失败
3. 单纯对于多端适应方案，通过使用单独的设计。@media screen and(mix-width: 1200px)
<!-- more -->
4. 分页功能在`_config.yml`添加`paginate: 5`  然后添加分页路径：`paginate_path: "blog/page:num"` ，还有分页插件jekyll-paginate
。
5. 关于标签。 可行方案1 ![Jekyll设置API统计文章数据](https://blog.fooleap.org/jekyll-tags-page.html)。 可行方案2 使用标签变量site.tags，显示所有标签-取变量的时候获取tag in site.tags 然后tag[0]是标签名字，tag[1]是具体内容。 可行方案3 多页面自定义设置
