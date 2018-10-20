---
layout: post
title:  "使用npm"
date:   2018-10-01 08:13:57 +0800
categories: node
description: node use.
---
# 使用npm

## 提出问题

 对于目前所用的npm的基础部分，我感觉很薄弱，然后我需要去了解最基本的使用和扩展方面的知识，通过了解这些内容来增加我的知识储备。

在做笔记的过程当中来学习如何去做笔记。

首先作为一个程序员，之前一直没有注意过版本问题，现在很有必要去实现他，用nvm来管理node的使用，而用npm来下载在网络上流行的各种包。所以我最开始的步骤是删除之前已经拥有的node的包和npm的包，然后下载nvm。

nvm的基础语法不多。

### nvm使用
使用的方法很简便。重点只需要记下这么几个。[下载地址](https://github.com/coreybutler/nvm-windows)
  1. 使用`nvm install <version>`下载具体版本`uninstall`
  2. `nvm list`查看node.js的安装，
  3. `nvm on/off`启动版本控制和关闭。
  4. `nvm use<version>`使用那个版本
  5. `nvm ls-remote` + `nvm current`
注意
nvm安装后需要配置环境，其一，不要自己去帮他创建文件。因为自动管理，使用nvm use的时候，会是修改一个快捷方式，自己尝试的时候发现，node的环境变量设置为e:/nodejs，然后在e下创建了一个nodejs的文件夹，nvm use后，不会自动切换，只能手动管理。npm是切到最新版的npm去设置npm全局安装包位置，然后安装全局npm（为了可以全局使用，然后设置他的环境变量）。
**扩展方面**--windows点击install.cmd配置环境
```
nvm node_mirror  https://npm.taobao.org/mirrors/node/
nvm npm_mirror https://npm.taobao.org/mirrors/npm/
nvm root <path> 设置路径
```
下载好后，我的步骤。

```
nvm node_mirror  https://npm.taobao.org/mirrors/node/
nvm npm_mirror https://npm.taobao.org/mirrors/npm/
nvm install latest
nvm use 10.11.0
npm config set prefix "E:\node\npm"
配置用户文件夹下 .npmrc
npm install npm -g --registry=https://registry.npm.taobao.org
```
之后不重要 nrm是npm源管理器
npm install -g cnpm --registry=http://r.cnpmjs.org

npm install -g nrm 
```

## npm使用命令

1. `npm outdated` 和`npm update` 
2. npm install 
    1. -g 是全局
    2. --save是保存到package.json作为dependency
    3. --save-dev 作为devDependency 
    4. 删除如上，参数类似，方法是uninstall

## 扩展方面
1.  `npm whoami`查看用户
2.  `npm adduser`+输入用户名密码和邮箱 添加用户
3.  `npm root`
4.  `npm ls`显示安装的包
5.  `npm star<package>` `npm stars`
6.  `npm doctor`检查环境，比如npm的地址，node版本，检查ping
7.  `npm docs`检查文档
8.  `npm build` `npm rebuild` 
9.  `npm prune` 移出无关的包`npm deprecate`移出重复包
10.  `npm repo <package>`在浏览器中打开指定的源码仓库页面
11.  `npm view`查看注册信息
12.  `npm publish`出版

```
    access, adduser, audit, bin, bugs, c, cache, ci, cit,
    completion, config, create, ddp, dedupe, deprecate,
    dist-tag, docs, doctor, edit, explore, get, help,
    help-search, hook, i, init, install, install-test, it, link,
    list, ln, login, logout, ls, outdated, owner, pack, ping,
    prefix, profile, prune, publish, rb, rebuild, repo, restart,
    root, run, run-script, s, se, search, set, shrinkwrap, star,
    stars, start, stop, t, team, test, token, tst, un,
    uninstall, unpublish, unstar, up, update, v, version, view,
    whoami

npm配置

folders

package-lock.json

package.json

npmrc

package-locks

shrinkwrap.json
```
