---
layout: post
title:  "Https加密和Apache反向代理问题!"
date:   2018-10-03 23:06:57 +0800
categories: ubuntu
---

# DigitalOcean VPS 加密服务器为HTTPS和反向代理

>因为有一些Token，登陆模块，想只放在一个自己常用的服务器，然后就使用了nodejs来作为一个登陆模块。在面对Microsoft outlook OAuth的时候发现一个问题，他的回调函数必须是https的样式的。于是，自己去找办法设置自己的网站的http进行加密。

*很多是网上找到的，自己只记下自己成功的步骤，不对过程做更多了解。*

*在这过程自己去gandi网站买了个6元的域名，gnoixiong.qw；修改为了digitalOcean的dns，发现需要很久才能更新成功，可以访问。修改为DigitalOcean的DNS是为了测试他自带的均衡加载，最后弄了快差不多的时候发现需要每个月10美元，放弃。*
## DigitalOcean VPS http 加密（Ubuntu17.0）**使用Let's Encrypt**
>第一次是Google到的，但是最后遇到的问题是不支持什么的错误，而且根据官网的解决办法无效，记得是`sudo certbot --authenticator standalone --installer apache -d www.gnoixiong.pw --pre-hook "service apache stop" --post-hook "service apache start"
`，2019年1月什么之前。[此刻时间2018.10.2]

### 根据[url](https://devanswers.co/lets-encrypt-ssl-apache-ubuntu-18-04/)成功
1. `sudo add-apt-repository ppa:certbot/certbot`
2. 输入Enter
3. `sudo apt update`
4. `sudo apt install python-certbot-apache`

![图1](https://res.cloudinary.com/xiongxiao/image/upload/v1538577134/github/images/2018-10-03-01.png)

5. `y`+`Enter`
6. `suto certbot --apache -d gnoixiong.pw -d www.gnoixiong.pw
xiongxiao1012@outlook.com`
7. `a`+`Enter`

![图2](https://res.cloudinary.com/xiongxiao/image/upload/v1538577134/github/images/2018-10-03-02.png)

8. `n`

![图3](https://res.cloudinary.com/xiongxiao/image/upload/v1538577134/github/images/2018-10-03-03.png)

9. 检测是否成功

![图4](https://res.cloudinary.com/xiongxiao/image/upload/v1538577134/github/images/2018-10-03-04.png)

```
如图类似的URL去检测
https://www.ssllabs.com/ssltest/analyze.html?d=www.gnoixiong.pw
https://www.ssllabs.com/ssltest/analyze.html?d=gnoixiong.pw
```
10. `sudo certbot renew --dry-run` 执行自动申请证书

## 反向代理问题
>当我的https弄好后，发现Microsoft需要https才行，而我弄好的只是php的，nodejs的3000端口还是http接口。所以需要反向代理，之前玩微信小程序的时候知道NGINX可以反向代理，而去了解资料知道Apache同样可以，并通过一系列查资料成功完成。

![图5](https://res.cloudinary.com/xiongxiao/image/upload/v1538577134/github/images/2018-10-03-05.png)

### 过程

1. 加载apache模块，使用a2enmod命令加载模块
2. 
```
a2enmod proxy proxy_balancer proxy_http
```

2. 配置反向代理功能，进入sites_available(Ubuntu /etc/apache2/sites_available)，创建一个新的站点配置文件(新建文件），然后编辑内容如下：

```
<VirtualHost *:80>
        #配置站点的域名
        ServerName xxx.com
        #off表示开启反向代理，on表示开启正向代理
        ProxyRequests Off
        ProxyMaxForwards 100
        ProxyPreserveHost On
        ProxyPass / http://127.0.0.1:3000/
        ProxyPassReverse / http://127.0.0.1:3000/
        <Proxy *>
            Order Deny,Allow
            Allow from all
        </Proxy>
</VirtualHost>
```

3. `a2ensite`加载刚才那个文件，然后 `systemctl restart apache2`  重启,即可。

### https的有东西
>在之前的http是可以已经算是完成了，然后代理也没毛病，然后却发现一个大的问题，https不行，仍旧是之前的443端口，而且没有代理。Google了一会，然后自己慢慢摸索已经是好的配置，关于443的配置。

1. 重复修改已经有的443的那个配置文件，发现一直不能成功。
2. 根据已经有的配置文件，复制出来，创建一个新的文件，通过`a2ensite` 加载新的文件，等于默认一个域名，代理一个域名，后成功。

***配置文件在最下***

参考文献:
    简书[zhengyu4767](https://www.jianshu.com/p/47eca94680aa) |
    CSDN[乐意黎](https://blog.csdn.net/aerchi/article/details/73605496) |
    自己对已经好的配置的理解，保存之前配置好的文件，很重要。


```
#关于HTTPS的配置文件
<IfModule mod_ssl.c>
<VirtualHost *:443>
ServerName www.gnoixiong.pw
DocumentRoot /var/www/LoginApi
SSLEngine On
Include /etc/letsencrypt/options-ssl-apache.conf
#ServerAlias www.gnoixiong.pw
SSLCertificateFile /etc/letsencrypt/live/gnoixiong.pw/fullchain.pem
SSLCertificateKeyFile /etc/letsencrypt/live/gnoixiong.pw/privkey.pem

ProxyRequests Off
ProxyMaxForwards 100
ProxyPreserveHost On
ProxyPass / http://127.0.0.1:3000/
ProxyPassReverse / http://127.0.0.1:3000/
<Proxy *>
        Order Deny,Allow
        Allow from all
</Proxy>

</VirtualHost>
</IfModule>

#关于HTTP的配置文件

<VirtualHost *:80>
        #配置站点的域名
        ServerName gnoixxiong.pw
        #配置站点的管理员信息
        ServerAdmin xiongxiao1012@outlook.com

        #off表示开启反向代理，on表示开启正向代理
        ProxyRequests Off
        ProxyMaxForwards 100
        ProxyPreserveHost On
        #这里表示要将现在这个虚拟主机跳转到本机的4000端口
        ProxyPass /var/www/LoginApi  http://127.0.0.1:3000/
        ProxyPassReverse /var/www/LoginApi http://127.0.0.1:3000/

        <Proxy *>
            Order Deny,Allow
            Allow from all
        </Proxy>

</VirtualHost>        
```

