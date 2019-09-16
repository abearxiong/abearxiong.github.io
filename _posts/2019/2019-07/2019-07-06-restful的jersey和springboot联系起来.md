---
layout: post
title: restful的jersey和springboot联系起来 
date: 2019-07-06 08:03:09 +0800 
categories: java 
tags: ["java", "springboot"]
notebook: java
comments: false
description: 一般使用restful是用springboot中直接@RestConstroller，但是上一次想学习JSR311去了解的这一个jersey，想去具体实现一下这个功能特点，所以去学习。环境搭建的时候因为JAX-RS1.0和JAX-RS2.0出现了问题（可能），所以记录一下过程。实际是扫描包的问题。
---
因为第一次搭建的时候我引入了我想可能会用到的包，使用maven把所有的包引入，然后根据配置和使用，发现访问那个resource的url会出现报错，报错的大概内容就是servlet的init初始化错误。
```
HTTP Status 500 - Servlet.init() for servlet jersey-serlvet threw exception?
```

之前一直以为是配置错误，所以我一直寻找资料去配置。

可能是思维没有想起来，查找了几个小时才想到，我的配置方式是没有问题的，那么是其他的地方出了问题，而我的编辑器也是没有问题的，springboot也是没有问题的，所以为什么会出现这个问题？因此我就想到，单独配置这么一个jersey服务进行测试。

之前查找资料的时候遇到过，如果JAX-RS1.0和JAX-RS2.0如果都有的话，那么会导致兼容什么类的问题的，但是我在网站上是没有看到那个包的，我引入的那些包是不是可能就引入了JAX-RS1.0,因为springboot jersey start默认的版本是JAX-RS2.0,所以是那个包引入了，我是不知道的，但是因为之前了解过两个都有会出问题，其他的配置的地方都是对的，所以我就单独的配置了一次的jersey。只引入jersey一个包，然后springboot启动，查看资源，结果成功了。

在那一刻的我心情很复杂，又是花了很长的时间去解决一个问题。

世界上很多的内容都是在网络上查找资料的，解决问题。搜索能力是一个解决方式，查看文档是一个方式，思维需要更跳跃，跳过一些模板框架，需要更快的去找到出现问题的根本点，然后才能解决问题的。

通过这个解决思路，我判断以后的解决思考，在实现解决的过程当中，如何更快的去找到更便捷的方式方法。

- 08：30

## 是哪个包？

引入的包那么多，到底是哪个包呢？所以我想去验证和查找一下，然后我原始的引入一个一个注释，还是那个问题？把我后面测试的jersey代码，只引入一个并成功的代码复制进去之前引入多个的，是可以成功的。所以我就发现，我的代码是有问题的！

```
package me.xiongxiao.life.plan.resources;

import java.util.HashMap;
import java.util.Map;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;

import org.springframework.stereotype.Component;

//@Path("/")
@Component
public class JerseyTest {
    @GET
    @Produces(MediaType.APPLICATION_JSON)
    @Path("/hello")
    public Map<String, Object> hello() {
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("code", "1");
        map.put("codeMsg", "success");
        return map;
    }
}
```
需要把@Path 放在类的上面，必须要有，如果没有会出找不到类的错。

出现servlet的错

```
@Component
//@ApplicationPath("/")
public class JerseyConfig extends ResourceConfig{
    public JerseyConfig() {
//        register(SpringbootResource.class);
//        register(RequestContextFilter.class);
//        packages("me.xiongxiao.life.plan.resources");
        register(JerseyTest.class);
        //配置restful package.
    }
}
```

## 由此推断，是扫描路径导致的servlet的错误的，如何去实现一个正确的扫描路径呢？



## 找到一个有效，扫面那个包的内容，然后装载。

```
package me.xiongxiao.life.plan.config;

import me.xiongxiao.life.plan.resources.JerseyTest;
import me.xiongxiao.life.plan.resources.SpringbootResource;
import org.glassfish.jersey.logging.LoggingFeature;
import org.glassfish.jersey.server.ResourceConfig;
//import org.glassfish.jersey.server.model.Resource;
import org.glassfish.jersey.server.spring.scope.RequestContextFilter;
import org.springframework.core.io.Resource;
import org.springframework.core.io.support.PathMatchingResourcePatternResolver;
import org.springframework.core.io.support.ResourcePatternResolver;
import org.springframework.core.type.classreading.CachingMetadataReaderFactory;
import org.springframework.core.type.classreading.MetadataReader;
import org.springframework.stereotype.Component;
import org.springframework.util.ClassUtils;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.filter.CorsFilter;

import javax.ws.rs.ApplicationPath;
import java.io.IOException;
import java.util.HashSet;
import java.util.Set;

@Component
//@ApplicationPath("/")
public class JerseyConfig extends ResourceConfig{
    public JerseyConfig() {
//        register(SpringbootResource.class);
//        packages("me.xiongxiao.life.plan.resources");
//        register(RequestContextFilter.class);
//        register(JerseyTest.class);
        registerClasses(findAllClasses());
//        packages("me.xiongxiao.life.plan.resources");
        // 注册日志
        register(LoggingFeature.class);
        // 异常处理
        register(ExceptionHandler.class);
        // 跨域过滤器注册
        register(CorsFilter.class);
    }
    /**
     * 由于spring boot 打包为jar包，jersey packages 无法扫描jar对应的文件夹的文件，故自定义包扫描
     * @return
     */
    private Set<Class<?>> findAllClasses(){
        String scanPackages = "me.xiongxiao.life.plan.*";
        ClassLoader loader = this.getClass().getClassLoader();
        Resource[] resources = new Resource[0];
        try {
            resources = scan(loader, scanPackages);
        } catch (IOException e) {
//            log.error("加载class异常",e);
        }
        return convert(loader, resources);
    }

    /**
     * 扫描 jar 包
     * @param loader
     * @param packageName
     * @return
     * @throws IOException
     */
    private Resource[] scan(ClassLoader loader, String packageName) throws IOException {
        ResourcePatternResolver resolver = new PathMatchingResourcePatternResolver(loader);
        String pattern = "classpath*:" + ClassUtils.convertClassNameToResourcePath(packageName) + "/**/*.class";
        return resolver.getResources(pattern);
    }

    /**
     * 加载 class
     * @param loader
     * @param resource
     * @return
     */
    private Class<?> loadClass(ClassLoader loader,Resource resource) {
        try {
            CachingMetadataReaderFactory metadataReaderFactory = new CachingMetadataReaderFactory(loader);
            MetadataReader reader = metadataReaderFactory.getMetadataReader(resource);
            return ClassUtils.forName(reader.getClassMetadata().getClassName(), loader);
        } catch (LinkageError | ClassNotFoundException e) {
//            if (log.isDebugEnabled()) {
//                log.debug("Ignoring candidate class resource " + resource + " due to " + e);
//            }
            return null;
        } catch (Throwable e) {
//            if (log.isWarnEnabled()) {
//                log.warn("Unexpected failure when loading class resource " + resource, e);
//            }
            return null;
        }
    }

    /**
     * resources 转换为 Set<Class>
     * @param loader
     * @param resources
     * @return
     */
    private Set<Class<?>> convert(ClassLoader loader,Resource[] resources){
        Set<Class<?>> classSet = new HashSet<>(resources.length);
        for (Resource resource : resources){
            Class<?> clazz = loadClass(loader, resource);
            if (clazz != null){
                classSet.add(clazz);
            }
        }
        return classSet;
    }
}
```