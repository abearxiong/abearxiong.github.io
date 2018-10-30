---
layout: post
title:  Ubuntu time is not Beijing time
date:   2018-10-29 17:00:00 +0800
categories: Ubuntu
tags: ubuntu
comments: true
#description: g
---
It's very sad about install ubuntu,and don't set time in Beijing Time zone,I also don't install chinese language.I use Ubuntu in vm, everytime I use `bundle exec jekyll serve`,and now date's article is don't show because of jekyll show that timezone's article. And when I run my Ruby program, the time is not I want to get.It's -7000 and I'm in +8000.So I offten make mistakes for use this timezone. So I change my Ubuntu timezone. Before I do this change, I installed Chinese language, but Make ubuntu collapse.It's very bad for me to use Ubuntu,Maybe is because Ubuntu's install source is not set chinese source.

How to change my Ubuntu timezone is learning from [csdn-zhengchaooo][bg1].
``` shell
 date -R  # To look my timezone
 tzselect # To change my timezone and choose 4 9 1 1
 sudo cp /usr/share/zoneinfo/Asia/Shanghai  /etc/localtime #cp file to local
 sudo date -s 17:00:00 #change Time
 sudo hwclock --systohc #change systohc
```
<!-- more -->


Edit History：
    2018-10-29 First draft

[bg1]: https://blog.csdn.net/zhengchaooo/article/details/79500032 "How to change Ubuntu time"
