---
layout: post
title: 在windows中的压缩文件zip到ubuntu中文乱码 
date: 2019-06-26 13:04:14 +0800 
categories: ubuntu 
tags: ["ubuntu", "windows"]
comments: false
description: 未解决的乱码，windows的压缩文件，在Ubuntu解压得到的内容是乱码的。
---
## 网上乱码，难受

windows 使用360zip,7z压缩包，复制到Ubuntu安装了unzip,unar去解压都是中文乱码

## 在网上查找的方法(未解决，以后如果遇到再想)

通过unzip行命令解压，指定字符集

```
unzip -O CP936 xxx.zip
```

用GBK, GB18030也可以

unzip –help对这个参数有一行简单的说明。