---
layout: null
title: Api example
date: 2018-10-15 18:20:00 +0800 
description: ruby 的后台json数据
permalink: /api/example.json
---
[
{% for post in site.posts %}
    {
        "title": {{ post.title | jsonify }},
        "url": {{ post.url | jsonify }},
        "categories": {{ post.categories | jsonify }},
        "date": "{{ post.date | date: "%B %d, %Y" }}",
        "tags": {{ post.tags | jsonify }},
	"description": {{ post.description |escape}}
    }{% unless forloop.last %},{% endunless %}
{% endfor %}
]
