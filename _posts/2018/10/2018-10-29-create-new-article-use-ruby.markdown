---
layout: post
title:  Use Ruby to create new article file
date:   2018-10-29 15:00:00 +8000
categories: Ruby
tags: ruby
description: Learn Ruby about file operating and make some note
---
#### Learn from [runoob.com][bg1]

First about File operating is diffierent from C,C++,Java.So I need learn ruby.

About I/O ruby has read,write,gets puts,readline,getc,printf;In stdin can use `str = gets` etc.<!-- more -->

New File is use `File.new("filename","mode")`, mode is `r r+ w w+ a a+`. Write File use `aFile.write` aFile is File class.Read File by readlines Or other IO.  
There is create Article file gist:

<script src="https://gist.github.com/abearxiong/e830331e0872031240a38d32b7f93e8f.js"></script>

#### Edit History：
- 2018-10-29 First draft. Create articel 
- 2018-11-07 repair gist

[bg1]: http://www.runoob.com/ruby/ruby-input-output.html "Runoob learning web"
