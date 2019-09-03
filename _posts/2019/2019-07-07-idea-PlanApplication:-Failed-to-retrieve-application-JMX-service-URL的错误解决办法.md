---
layout: post
title: idea PlanApplication Failed to retrieve application JMX service URL的错误解决办法 
date: 2019-07-07 12:07:56 +0800 
categories: java 
tags: ["springboot", "idea", "使用技巧"]
notebook: java
comments: false
description: idea出现了错误，如何解决，Evert Log出现，2019.01的版本
---
[stackoverflow](https://stackoverflow.com/questions/54929656/intellij-idea-not-showing-anything-endpoints-tab-failed-to-retrieve-applicatio?rq=1)

I also encountered this problem and finally found the answer:

Starting from 2018.3.4 IntelliJ IDEA use local JMX connector for retrieving Spring Boot actuator endpoint's data. Local JMX monitoring has some restrictions, in particular, it isn't possible to get local JMX connector address if Spring Boot application and IntelliJ IDEA JVMs have different bitness. If it is not possible to run application on JVM with the same bitness, then, in order to fix the problem, one could add the following to Spring Boot run configuration's VM options:

-Dcom.sun.management.jmxremote.port={some_port} -Dcom.sun.management.jmxremote.authenticate=false -Dcom.sun.management.jmxremote.ssl=false


after setting: enter image description here
![imgs](https://i.stack.imgur.com/LSFML.png)

jetbrains issue link:https://youtrack.jetbrains.com/issue/IDEA-204797

## VM options设置位置

是启动springboot的运行的位置，Edit进行启动配置，找到环境的vm那个地方，复制粘贴，其中{}修改一个端口的位置。

## 查看mapping

spring-boot-starter-actuator 来使用'Endpoints'的标签栏，其中Mappings可以得到所有的Maping对象，很容易的进行测试程序运行。