---
layout: post
title: 小程序使用vant-weapp UI 
date: 2019-08-01 11:13:21 +0800 
categories: 前端
tags: ["微信小程序"]
notebook: 前端
comments: false
description: 使用vant-weapp的构建方式。
---
初始引入

1. miniprogram右键打开终端输入npm i vant-weapp -S --production 出现package-lock.json
2. 之后输入npm init -y =》出现package.json
3. 查看package.json详情，本地设置，“使用npm模块”勾选
4. 在“工具”，选择”构建npm“

出现miniprogram_npm


使用方式，在页面json中使用引入
```
{
    "usingComponents":{
        "van-button": "vant-weapp/button"
    }
}
```
在xml引入模块
```
<van-button type="primary">按钮<van-button>
```