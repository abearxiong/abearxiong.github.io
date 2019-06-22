---
layout: post
title: Github Oauth App登录模块 
date: 2019-06-22 23:32:45 +0800 
categories: github 
tags: ["github", "life"]
comments: false
description: GitHub Oauth App在html页面实现第三方登录，得到access_token，实现获取GitHub中的一些有趣的内容。感觉非要后端不可，因为Github的地址，用ajax或者fetch，都会有跨域问题。
---
GitHub 中的具有OAuth Apps，申请后可以具有第三方登录。

## OAuth Apps

[New OAuth App](https://github.com/settings/applications/new)

通过登录后，可以获取`acess_token`,然后根据Apps的权限，实现具体对应的功能。

## 缘由

我想在GitHub page中实现类似gitalk的功能，但是我不需要一些，需要我独特的功能。

我可以通过GitHub page得到issues的内容，和添加issues的内容，然后那个页面和自己在QQ空间中的功能就很类似。自己就可以在自己的小空间实现一个很欢乐的保留和记忆，还有各种标签。通过标签查询，这是一个很有用的日志功能，而别人可以通过issues来做blog，为什么，issues就不能作为一个后端，然后实现我现在需要的功能呢？

# 如何实现OAuth Apps的登陆

OAuth Apps第三方登录是一个很简单的事情。条理顺序是

### 1. 申请

最开始是申请Oauth App，得到client_id和client_secret。

### 2. Get请求
发送请求到url是`https://github.com/login/oauth/authorize` 。参数内容是client_id=值,redirect_url,scope等等

会返回一个code的url，提取code的值

### 3. Post请求
发送请求url是 `https://github.com/login/oauth/access_token`。参数内容是client_id,redirect_url,scope,code,client_secret

如果是对的，那么会返回一个access_token，那么就可以通过access_token进行操作好玩的事情了。

### 一个html就够了

所有相应的功能，一个html就够了，但是为了secret保险，那么应该需要一个转发平台，微小的服务，进行把client_secret进行隐藏。我觉得 无服务器云函数是可以实现这一个功能的。

### 例子

在一个html中，根据获取的href，进行判断进行的步骤。得到的access_token保存到localStorage进行永久保存，如果保存了，那么相当于是登录的状态。
```html
<!DOCTYPE html>
<html>
<head>
    <title>github登录</title>
</head>
<body>
登录登录

<script type="text/javascript">
    (()=>{
        let url = "https://github.com/login/oauth/authorize"
        // let client_id = `ccf21c3104b11fcd9219` // xx-space
        let client_id = `6d1f0f1a67b21e729050` //xx-space-local-dev
        let client_secret = `22cbbe70c70edb70097236f0b8e51c46b8ac460e`
        let redirect_uri = encodeURIComponent(window.location.href)
        // let redirect_uri = encodeURIComponent("https://abearxiong.github.io/space")
        // fetch(`${url}?client_id=${client_id}&redirect_uri=${redirect_uri}&scope=public_repo`)
        let loginLink = `${url}?client_id=${client_id}&redirect_uri=${redirect_uri}&scope=public_repo`
        console.log("login",window.location.href)
        let nowHref = window.location.href
        let hasCode = /code/
        let hasAccesssCode = /access_token/
        if(hasCode.test(nowHref)){
            let code = nowHref.split("=")[1]
            console.log("获得code",code)
            let url_token = "https://github.com/login/oauth/access_token"
            let getTokenUrl = `${url_token}?client_id=${client_id}&client_secret=${client_secret}&code=${code}&redirect_uri=${redirect_uri}&scope=public_repo` 
            let getTokenUrl2 = `${url_token}?client_id=${client_id}&client_secret=${client_secret}&code=${code}&scope=public_repo` 
            console.log("请求的url：",getTokenUrl)
            window.location.href = getTokenUrl
        }
        else if(hasAccesssCode.test(nowHref)){
            console.log("获得access token")
        }
        else{
            window.location.href = loginLink
        }
    })()
</script>
</body>
</html>
```

### 问题

各种跨域问题？ fetch cors，ajax跨域有问题。所以非要服务器，本html是利用直接访问url，就没有跨域问题，但是获取的内容，下到了电脑里面呀？？？？？