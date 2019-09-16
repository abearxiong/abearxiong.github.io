---
layout: post
title: springboot jersey合用问题？ 
date: 2019-07-07 12:05:52 +0800 
categories: java 
tags: ["springboot"]
notebook: java
comments: false
description: 使用了controller，又使用jersey拦截，如果没有根路径，那么会造成controller的拦截不了。
---

```
package me.xiongxiao.life.plan.config;

import org.glassfish.jersey.logging.LoggingFeature;
import org.glassfish.jersey.server.ResourceConfig;
//import org.glassfish.jersey.server.model.Resource;
import org.springframework.core.io.Resource;
import org.springframework.core.io.support.PathMatchingResourcePatternResolver;
import org.springframework.core.io.support.ResourcePatternResolver;
import org.springframework.core.type.classreading.CachingMetadataReaderFactory;
import org.springframework.core.type.classreading.MetadataReader;
import org.springframework.stereotype.Component;
import org.springframework.util.ClassUtils;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.filter.CorsFilter;

@Component
@ApplicationPath("/resource")
public class JerseyConfig extends ResourceConfig{
    public JerseyConfig() {
        register(JerseyTest.class);
    }
}
```

@ApplicationPath 是必须有的，不然会主动拦截所有的url地址。