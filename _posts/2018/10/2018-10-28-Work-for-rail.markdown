---
layout: post
title:  Learn Rake
date:   2018-10-28 15:00:00 +8000
categories: Ruby
tags: rake
description: Learn Rake and make some note
---
1. Install rake.  
I use Ubuntu and I install Gem for Ruby.So I install it by commond `gem install rake`.
2. create the first Rake task.
{% highlight Ruby %}
desc "some explian language"
task :task_name do
    # coding 
    puts "print some in bash"
end
desc "use input"
task :task_name_input,:a do|t,args|
    # coding 
    puts "print some in bash:",args
    # t is `task_name_input` args is 'input paramater'
end
{% endhighlight %}
3. Rake bash commond  
- `Rake -T` is show all task. And it can show task description.  
- `Rake task_name` is run task by task name `task_name`.
- `Rake task_name_intpu[1]` is can input some paramater.

Edit History：
    2018-10-28 First draft

