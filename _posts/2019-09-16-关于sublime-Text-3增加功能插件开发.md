---
layout: post
title: 关于sublime Text 3增加功能插件开发 
date: 2019-09-16 23:18:49 +0800 
categories: Sublime Text 3 
tags: ["plugin", "插件", "Sublime"]
notebook: Sublime Text 3
disqus: false
gitalk: true
description: 根据对插件的学习，创建了一个插件，理解了插件的功能模块，对之后sublime text的插件编写做了一个开头。并记下我，想做什么插件。
---

```
import sublime
import sublime_plugin
import threading
import time

class ExampleCommand(sublime_plugin.TextCommand):
    def run(self, edit):
        self.view.insert(edit, 0, "Hello, World!")

i=0

class timer(threading.Thread): #The timer class is derived from the class threading.Thread  
    def __init__(self, num, interval):
        threading.Thread.__init__(self)
        self.thread_num = num
        self.interval = interval
        self.thread_stop = False 
    def run(self): #Overwrite run() method, put what you want the thread do here
        global i
        while not self.thread_stop:
            sublime.set_timeout(write_time,1)
            i+=1  
            time.sleep(self.interval)          
    def pause(self):        
        self.thread_stop = True
    
    def zero(self):
        global i
        i=0    



thread1 = timer(1, 1)
class gtimerCommand(sublime_plugin.TextCommand):    
    def run(self, edit):
        global thread1
        thread=timer(1,1) 
        if thread1.isAlive():
            live=True
        else:                               
            thread.start()
            thread1=thread

class gtimerpauseCommand(sublime_plugin.TextCommand):    
    def run(self, edit):         
        global thread1
        thread1.pause()

class gtimerzeroCommand(sublime_plugin.TextCommand):    
    def run(self, edit):
        global thread1         
        thread1.zero()
        
   
def write_time():
    sublime.status_message(time_manage(i))

def time_manage(time_number):
    time_str=' time: '+str(int(time_number/60))+'min '+str(time_number%60)+'s'
    return time_str

# ---
# layout: post
# title: 关于sublime Text 3增加功能插件开发 
# date: 2019-09-16 23:18:49 +0800 
# categories: Sublime Text 3 
# tags: ["plugin", "插件", "Sublime"]
# notebook: Sublime Text 3
# disqus: false
# gitalk: true
# description: 对内容的描述
# ---

class ToltCommand(sublime_plugin.TextCommand):
    '''
    格式化<>标签进行转义
    '''
    def run(self, edit):
        for region in reversed(self.view.find_all("<")): 
            if not region.empty(): 
                self.view.replace(edit, region, "&lt;") 
        for region in reversed(self.view.find_all(">")):
            if not region.empty():
                self.view.replace(edit, region, "&gt;")

class NltCommand(sublime_plugin.TextCommand):
    def run(self, edit):
        for region in reversed(self.view.find_all("&lt;")):
            if not region.empty():
                self.view.replace(edit, region, "<")        
        for region in reversed(self.view.find_all("&gt;")):
            if not region.empty():
                self.view.replace(edit, region, ">")
```

以上是源码，搜索资料研究的关于状态栏的运行时间，关于转义标签的问题。

[api文档 english](https://www.sublimetext.com/docs/3/api_reference.html)

[api document chinese](https://feliving.github.io/Sublime-Text-3-Documentation/api_reference.html)

[文档](https://sublime-text.readthedocs.io/en/latest/intro.html)

### 命令面板 

是一个绑定到键盘 Ctrl+Shift+P 的交互列表，其目的在意执行命令。命令面板 与命令文件相互联系。通常，命令不保证产生一个按键绑定，可以在 .sublime-commands 中作为一些很好的候选。

Defult.sublime-commonds

```
[
    { "caption": "Time Start", "command": "gtimer" },
]
```
