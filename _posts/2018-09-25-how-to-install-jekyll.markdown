---
layout: post
title:  "关于第一次搭建Jekyll的总结"
date:   2018-09-25 00:00:00 -0700
categories: jekyll blog
---

# 从零开始搭建Jekyll

>距离搭建完成Jekyll已经有很多天了，然后今天来总结一下当时的做法和想法。和当时记下的一点笔记。

## 安装过程

首先安装Ruby20，却发现Ruby主要流行在Linux社区，在window社区对新手很不友好，网上如是说，所以我听从了建议，不安装window版本，但是自己也没有linux的电脑，除了vps服务器。但是用来做git托管网站，还是放在自己电>脑更好了。于是我首先安装了VMware Workstation14,下载地址：搜简书CSDN很多，下载Ubuntu18.04,Ubuntu中文网，官网都有，简略安装方式--ubuntu安装。只是因为Ubuntu18好像硬件需求2G以上让我考虑了一会，自己电脑能带动不，但是一直找不到16.04的>需求，最后还是选择了18.04版本。在2或者3个小时内，边学习其他，边下载和安装，搞定后开始学习安装jekyll。

第一步：安装 Ruby和RubyGems.
```
sudo apt install Rubu RubyGems
```

第二步：安装jekyll,安装需要前置依赖，g++，gcc，make；如果没有自己安装（`apt install g++ gcc make`)
```
gem install jekyll
```

第三步：安装bundler
```
gem install jekyll bundler
```

第四步：创建自己的博客，进入博客根目录并初始化和本地化服务
```
jekyll new myblog
bundler install
bundle exec jekyll serve
```

第五步：克隆自己name.github.io的项目（安装设置git[方法](#git简略设置))
```
git clone git@github.com:abearxiong.github.io.git
```
复制博客中的内容到自己设置的项目中
第六步：提交自己更改的内容
```
git add .
git commit -m "提交备注名"
git push
```
到自己的name.github.io查找自己的结果。安装完全结束。之后的内容就是对自己的托管博客进行自定义操作。进行修改自己的主题设置。

## 安装原因

突然间有点无聊了，然后就想到了我的abearxiong.io的小托管什么的网站，我过去什么都没有做，因为什么联想到了这个，于是去关注了hexo，jekyll和hugo。应该最先看到的是hexo，看到有个github.io的网站，然后看到他托管了三个网站，同一个类容，突然就很想去了解这些东西。然后了解hexo和jekyll的区别，再知道hugo。百度和google到的内容全都是hexo和从jekyll，很奇怪，看到github中star的还是jekyll多，我也不知道为什么。
![github比较图](https://res.cloudinary.com/xiongxiao/image/upload/v1538282254/github/images/2018-9-30.png)

对这几门而言，在Google的过程中，自己也不知道该选jekyll还是选择hexo，然后突然发现一个真实情况，github中推的jekyll，相当于jekyll是github推荐的，那么何不必在github中使用jekyll呢，如果还有兴趣，在码云和coding中各种搭建一个不同类型的呢。也许还是挺有趣的。

说动就动的旅行开始了，开始了解更深入的jekyll，发现他是一门我从没有接触的Ruby语言而来的，了解Ruby的过程中，很多人赞扬他的语法糖，对于我来说，也许我接触这个，也是接触了一门新的语言了，又可以玩耍一门新的语>言就是很好玩的一件事情了。毕竟在学校此刻的我就是一种奇怪的人，如果交计算机作业，项目什么的，我就在想，我是不是能交一个新的作业，新的不同的没有学过的语言来编写的作业，java，c#，c，mfc，nodejs，php等等。都
是很有趣的语言。

## 扩展阅读

### ubutu安装

安装ubuntu 快速版
可以使用软件
1. Universal USB Installer
2. rufus
两个都是刻录U盘的工具。把下载下来的ios格式的Ubuntu刻录到U盘
直接U盘启动，也不需要去看什么教程。
直接下一步，下一步，然后就完成了。 

如果安装window也是类似的，在window下可以直接点开window的ios安装包安装window或者更新windows。

如果安装到虚拟机，只是不需要使用这个软件罢了。

### git简略设置 [安装过程](#安装过程)

>这里主要讲一点git的基础配置问题
在Ubuntu内，需要远程github，然后才能进行操作其他的必要的内容。
1. 第一配置邮箱等信息
2. 第二设置rsa配置问题
3. 拷贝内容到github网站。

配置全局姓名和邮箱
```
git config --global user.name "abearxiong"

git config --global user.email "xiongxiao1012@outlook.com"
```
配置rsa
```
ssh-keygen -t rsa -C "xiongxiao1012@outlook.com"
cd ~/.ssh/id_rsa.pub 

#复制内容到github中
```

复制id_rsa.pub的内容到github中


基本使用方法

git pull  #更新到远
git add . #本地修改和增加
git push  #推送
git status #状态
