---
layout: null
permalink: /api/posts.json
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
