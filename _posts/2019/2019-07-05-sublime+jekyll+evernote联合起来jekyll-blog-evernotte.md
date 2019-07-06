---
layout: post
title: sublime+jekyll+evernote联合起来
date: 2019-07-05 11:17:50 +0800 
categories: jekyll
tags: ["blog", "evernote"]
notebook: 代理
comments: false
description: 在使用印象笔记记录我的传说之旅的时候，并我使用sublime编写我的jekyll文档的时候，发现evernote的一个插件很好的替我完成了一个复制粘贴到印象笔记的过程。但是转发过去有一些不得不修正的一些格式，或者其他要求。sublime+jekyll+evernote完美的实现了我的部分需求。若有机会，自己去阅读源码，进行更深入的个性化定制功能。
---
使用了sublime和他的插件

[Sublime Text](http://www.sublimetext.com/3) plugin for [Evernote](http://www.evernote.com)


[SublimeEvernote](https://github.com/jamiesun/SublimeEvernote)

需要的内容是获取印象笔记token：[https://app.yinxiang.com/api/DeveloperToken.action](https://app.yinxiang.com/api/DeveloperToken.action)

使用的技巧：

ctrl+e,s是发送内容到印象笔记

## 大体印象笔记的yml和jekyll的yml可以通用，并可以通用部分markdown

## copy Commands

The plugin does not install keymaps, if you wish you may add a variation of the following to your user keymaps:

```
{ "keys": ["super+e"], "command": "show_overlay", "args": {"overlay": "command_palette", "text": "Evernote: "} },
{ "keys": ["ctrl+e", "ctrl+s"], "command": "send_to_evernote" },
{ "keys": ["ctrl+e", "ctrl+o"], "command": "open_evernote_note" },
{ "keys": ["ctrl+e", "ctrl+u"], "command": "save_evernote_note" },
```

## copy metadata

```yaml
---
title: My Note's Title
tags: misc, sublime
notebook: My Notebook 
---
```

## copy Settings

The `Evernote.sublime-settings` can be accessed from `Preferences > Package Settings > Evernote`.

The two settings `token` and `noteStoreUrl` are set by the plugin in the [first use](#first-use).

The following settings can be customised:

Setting                   | Purpose
--------------------------|------------------------
`md_syntax`               | a string pointing to a `tmLanguage` file which you want to associate with notes opened from Evernote.
`inline_css`              | a dictionary associating some HTML element names to inline CSS styles; this setting is documented in the [wiki](https://github.com/bordaigorl/sublime-evernote/wiki/Styling). The markdown of a note can contain (almost) arbitrary HTML blocks *but* Evernote only accepts a subset of the elements and attributes (`class` and `id` are disallowed). See [here](http://dev.evernote.com/doc/articles/enml.php) for details.
`code_highlighting_style` | a pygments style among `autumn`, `default`, `github`, `monokai`, `perldoc`, `vim`, `borland`, `emacs`, `igor`, `murphy`, `rrt`, `vs`,   `bw`, `friendly`, `native`, `tango`, `xcode`,   `colorful`, `fruity`, `manni`, `pastie`, `trac`.
`code_friendly`           | if `true` the `code-friendly` extra of markdown2 is enabled
`evernote_autocomplete`   | when this setting is true, suggestions will be offered for autocompletion of the `notebook` and `tags` fields in metadata. Default is true.
`emphasis_mark`           | when converting from HTML to markdown, use this as emphasis markup. Valid values are `"*"` or `"_"` (default). It is set to `"*"` when `code_friendly` is true.
`strong_mark`             | when converting from HTML to markdown, use this as emphasis markup. Valid values are `"__"` or `"**"` (default)
`item_mark`               | when converting from HTML to markdown, use this as unordered list item markup. Valid values are `"+"`, `"-"` or `"*"` (default)
`notes_order`             | how to sort the notes in the panels; possible values: `created`, `updated`, `relevance`, `update_sequence_number`, `title`. Set the `notes_order_ascending` setting to `true` to reverse the selected order.
`max_notes`               | maximum number of notes in a panel; default is 100.
`update_on_save`          | when this setting is true, saving a file containing a note will also update (overwriting it) the online version. Default is false.
`sort_notebooks`          | sorts notebooks alphabetically in palette
`show_stacks`             | shows the stack of notebooks in palette
`open_single_result`      | when a search returns only one note open it directly skipping the results palette (defaults to `true`)
`warn_on_close`           | when closing a modified note without saving to Evernote, offer a choice to save or discard changes (defaults to `true`)
`gfm_tables`              | enable GFM table syntax (default `true`)
`default_template`        | a file with a Markdown template for new notes (example: `"Packages/User/EvernoteNote.md"`)
`tab_prefix`              | a string used as a prefix in tabs for notes (default `"Evernote: "`)
`wiki_tables`             | enable Wiki table syntax (default `false`)
`debug`                   | enables logging in the console