---
layout: post
title: springboot上传文件的方法 
date: 2019-07-07 15:08:05 +0800 
categories: java 
tags: ["springboot"]
notebook: java
comments: false
description: 上次文件已经知道的要点，需要保存的路径，第二得到输入流，第三输出内容。
---
编程的时候，如何获得，如何保存。

```
    @POST
    @Consumes(MediaType.MULTIPART_FORM_DATA)
    public String upload(@FormDataParam("file") InputStream fis,
                         @FormDataParam("file") FormDataContentDisposition disposition,
                         @Context ServletContext ctx) {
//        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        File upload = new File("./upload",
                UUID.randomUUID().toString() + "." + FilenameUtils.getExtension(disposition.getFileName()));
        try {
            FileUtils.copyInputStreamToFile(fis, upload);
//            IOUtils.copy(fis, baos);
//            String content = new String(baos.toByteArray());
//            return content;
//            ctx.
            return "success" + ctx.getRealPath(".") +" \n"+ctx.getResourcePaths("/")+"\n"+ctx.getResource("b9239698-ce5d-49e0-87b8-2afe716ca50c.txt");
        } catch (IOException e) {
            e.printStackTrace();
        }
        return null;
    }
```
ctx.getRealPath()会是tomcat的路径

如果是'./'是项目对应的路径

在之后的想法之后，觉得用cos文件对象存储更好。

- 17：15

发现如果直接用 "/upload" 是存在于 盘符的根目录下面。

所以是可以的不需要cos的，使用cos的原因是因为，当我去保存文件的时候，发现不能确定保存在那个位置，所以想放cos。

如果确定了放根目录下面，那么内容的位置是稳定的，所以是可以不需要放cos，毕竟cos放的内容和服务器放的内容是一致的，实际上存放的最多的内容，我也是不会超过服务器的限度的。所以有必要不放cos。

- 2019-07-07 补充


```
package me.xiongxiao.life.plan.resource;

//import org.apache.tomcat.util.http.fileupload.FileUtils;
import me.xiongxiao.life.plan.util.Log;
import me.xiongxiao.life.plan.util.Time;
import org.apache.commons.io.FilenameUtils;
import org.apache.commons.io.FileUtils;
import org.apache.tomcat.util.http.fileupload.IOUtils;
import org.glassfish.jersey.media.multipart.FormDataContentDisposition;
import org.glassfish.jersey.media.multipart.FormDataParam;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import javax.servlet.ServletContext;
import javax.ws.rs.*;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.net.URL;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

/**
 * @ClassName FileResource
 * @Desctiption 描述
 * @Author Abear
 * @Date 2019/7/7 11:09
 * @Version 1.0
 **/
@Component
@Path("/file")
public class FileResource {
    @Autowired
    public Log LOGGER;
    @GET
    @Produces(MediaType.APPLICATION_JSON)
    public Map<String, Object> hello() {
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("code", "0");
        map.put("msg", "success");
        return map;
    }
    // curl -X POST -F "file=@demo.txt" http://localhost:8081/resource/file
    @POST
    @Consumes(MediaType.MULTIPART_FORM_DATA)
    public String upload(@FormDataParam("file") InputStream fis,
                         @FormDataParam("file") FormDataContentDisposition disposition,
                         @Context ServletContext ctx) {
//        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        String year_month = Time.getYearMonth();
        String file_path = "/upload/" + year_month;
        String extension = FilenameUtils.getExtension(disposition.getFileName());
        if(extension.equals("")){
            return "No extension. Don't know what is it.";
        }
        String file_name = UUID.randomUUID().toString() + "." + FilenameUtils.getExtension(disposition.getFileName());
        LOGGER.i("FILENAME:" + file_name +" ");
        File upload = new File(/*ctx.getRealPath(file_path)*/file_path,file_name);
        try {
            FileUtils.copyInputStreamToFile(fis, upload);
//            IOUtils.copy(fis, baos);
//            String content = new String(baos.toByteArray());
//            return content;
            return "success" + ctx.getRealPath(".");
        } catch (IOException e) {
            e.printStackTrace();
        }
        return null;
    }

}
```
- 2019-07-08 补充