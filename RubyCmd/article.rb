#!/usr/bin/ruby
# -*- coding: UTF-8 -*-
time = Time.new
 
# Time 的组件
puts "当前时间 : " + time.inspect
puts time.year    # => 日期的年份
puts time.month   # => 日期的月份（1 到 12）
puts time.day     # => 一个月中的第几天（1 到 31）
puts time.wday    # => 一周中的星期几（0 是星期日）
puts time.yday    # => 365：一年中的第几天
puts time.hour    # => 23：24 小时制
puts time.min     # => 59
puts time.sec     # => 59
puts time.usec    # => 999999：微秒
puts time.zone    # => "UTC"：时区名称
time2 =Time.now
puts time2
infos =time2.to_s.split(" ")
puts infos[0]
filename = "test.markdown"
File.open(filename, "w+") do |aFile|
	   aFile.write("test")
	   aFile.write("d")
end
