---
layout: post
title: Electron C# dll hook获取活动窗口的进程和路径 
date: 2019-09-15 15:57:52 +0800 
categories: EElectron 
tags: ["Electron", "Nodejs", "C#", "dll"]
notebook: Electron
disqus: false
gitalk: true
description: Electron 抓取底层的系统信息。获取活动窗口的进程名，进程id和路径位置。主要使用Electron,electron-edge-js，C#生成库文件。
---
在实现这个要求前，需要有node-gyp，node-gyp需要有python2.7,visual studio2015的什么动态链接库。为了简便方法的安装，我安装的的方法是直接安装windows-build-tools的包。

## Windows的环境

### 1. 安装gyp
```npm
npm i -g node-gyp
```

### 2. 安装扩展包
```
npm install --global --production windows-build-tools
```

### 3. 配置python路径

路径的位置是在系统用户的文件夹下的.windows-build-tools里面。c:/user/用户/.windows-build-tools

```node
node-gyp python --python /path/to/python27
```

## 安装Electron

```
npm i -g electron@latest
```

### 1. 建立工程

```npm
mkdir electron-demo
npm init
npm i electron
npm i electron-edge-js
```

### 2. 初始化`index.html`和`index.js`

index.html

```
<!DOCTYPE html>
<html><head></head>
<body>
   测试<input type="text" />
</body>
</html>
```

`index.js`

```
const { app,BrowserWindow } = require('electron')
var edge = require('electron-edge-js')
// let createWindow =  () =>{
//     let win = new BrowserWindow ({
//         nodeIntegration: true
//     })
//     win.loadFile("index.html")
//     console.log("启动",Number.parseInt('256')) //发现的程序内的hook
//     win.hookWindowMessage(Number.parseInt('256'),( wParm, lParm)=>{
//         let eventName = null
//         console.log(wParm,"参数")
//     }) //Number.parseInt('0xD')
//     let isHook = win.isWindowMessageHooked(Number.parseInt('256'))
//     console.log(isHook)
//     let fileName = win.getRepresentedFilename()
// }

let createWindow = () => {
    let win = new BrowserWindow({
        nodeIntegration: true
    })
    win.loadFile("index.html") // 加载HTML
    console.log("启动")
    let HelloDll = edge.func({
        assemblyFile: 'winkey.dll',
        typeName: 'winkey.GetActivity',
        methodName: 'HelloDll'
    }) // 测试DLL
    let HookStart = edge.func({
        assemblyFile: 'winkey.dll',
        typeName: 'winkey.GetActivity',
        methodName: 'HookStart'
    }) // 开始进程
    let GetData = edge.func({
        assemblyFile: 'winkey.dll',
        typeName: 'winkey.GetActivity',
        methodName: 'GetData'
    }) // 获取进程的变量
    HelloDll(1, 2, function (err, result) {
        if (err) {
            console.log("err", err)
        } else {
            console.log("result", result)
        }
    })
    HookStart(1,function(err,result){
        if (err) {
            console.log("err", err)
        } else {
            console.log("HookStart result", result)
        }
    })
    setInterval(() => {
       GetData(1,function(err,result){
        if (err) {
            console.log("err", err)
        } else {
            console.log("result", result)
        }
       })
    }, 2000);   // 每隔两秒进行打印所激活窗口的一些值，进程名字，进程ID，进程的路径
}
app.on('ready', createWindow)
```

### 3. C# 创建DLL，建立Hook窗口的程序

1. 使用Visual Studio创建工程

新建，选择类库（.Net FrameWork),自己创建自己的工程，我创建的是winkey,修改文件名类的名字GetActivity,和Electron的对应。

```
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Runtime.InteropServices;
using System.Text;
using System.Threading.Tasks;
using System.Windows;


namespace winkey
{
    public class GetActivity
    {
        private System.Threading.Timer threadTimer;
        private Process myProcess;
        volatile public static String Data ="内容";
        public async Task<object> HelloDll(object input)
        {
            Console.WriteLine("输入HelloDLL");
            Console.WriteLine(input);
            return "helloDll";
        }
        public async Task<object> GetData(object input)
        {
            Console.WriteLine("Data---"+ GetActivity.Data);
            return GetActivity.Data;
        }
        public async Task<object> HookStart(object input)
        {
            threadTimer = new System.Threading.Timer(new System.Threading.TimerCallback(GetValue), null, 0, 2000);
            return "start";
        }
        public async Task<object> HookEnd(object input)
        {
            threadTimer.Dispose();
            return "0";
        }
        [DllImport("User32.dll")]
        public static extern IntPtr GetForegroundWindow(); //获取活动窗口句柄

        [DllImport("User32.dll")]
        public static extern int GetWindowThreadProcessId(IntPtr hwnd, out int ID); //获取线程ID

        /// <summary>
        /// 获取进程的内容
        /// </summary>
        /// <param name="state"></param>
        private void GetValue(Object state)
        {
            //Thread.Sleep(3000);    //睡眠3s，用来选择活动窗口
            IntPtr hWnd = GetForegroundWindow();    //获取活动窗口句柄
            int calcID = 0;    //进程ID
            int calcTD = 0;    //线程ID
            calcTD = GetWindowThreadProcessId(hWnd, out calcID);
            myProcess = Process.GetProcessById(calcID);
            String getInfo;
            try
            {
                getInfo = "进程名：" + myProcess.ProcessName + "\n" + "进程ID：" + calcID + "\n" + "程序路径：" + myProcess.MainModule.FileName;
                //Console.WriteLine(getInfo);  //在MessageBox中显示获取的信息
                GetActivity.Data = getInfo;
            }
            catch
            {
                getInfo = "程序不能读取路径" + "进程名：" + myProcess.ProcessName + "\n" + "进程ID：" + calcID + "\n"; // 不能获取类似于cmd的路径，所以就try catch
                //Console.WriteLine(getInfo);
                GetActivity.Data = getInfo;
            }

        }
    }
}


```

2. 生成DLL文件

在自己的bin/debug里面

3. 复制到Electron的根目录，根据自己Electron读取的路径进行自定义

4. 在Electron的路径运行 `electron . ` 因为安装了全局的electron，所以直接运行就好了。

执行的结果如图 electron-hook.gif

![elctron-hook](https://res.cloudinary.com/xiongxiao/image/upload/v1568537455/github/images/electron-hook.gif)


[代码地址](https://github.com/abearxiong/databank/blob/master/Super%20Desktop/electron-hook-demo.zip)