---
layout: post
title: You Dont Need jQuery 
date: 2019-10-03 19:40:42 +0800 
categories: JavaScript 
tags: ["JavaScript", "前端"]
notebook: JavaScript
disqus: false
gitalk: true
description: 网上复制的一个好文章，放在要背的，关于原生和jQuery的区分。
---
## You (Might) Don't Need jQuery [![Build Status](https://api.travis-ci.org/nefe/You-Dont-Need-jQuery.svg)](https://travis-ci.org/nefe/You-Dont-Need-jQuery)

前端发展很快，现代浏览器原生 API 已经足够好用。我们并不需要为了操作 DOM、Event 等再学习一下 jQuery 的 API。同时由于 React、Angular、Vue 等框架的流行，直接操作 DOM 不再是好的模式，jQuery 使用场景大大减少。本项目总结了大部分 jQuery API 替代的方法，暂时只支持 IE10 以上浏览器。

## 目录

1. [Translations](#translations)
2. [Query Selector](#query-selector)
3. [CSS & Style](#css--style)
4. [DOM Manipulation](#dom-manipulation)
5. [Ajax](#ajax)
6. [Events](#events)
7. [Utilities](#utilities)
8. [Promises](#promises)
9. [Animation](#animation)
10. [Alternatives](#alternatives)
11. [Browser Support](#browser-support)

## Query Selector

常用的 class、id、属性 选择器都可以使用 `document.querySelector` 或 `document.querySelectorAll` 替代。区别是
* `document.querySelector` 返回第一个匹配的 Element
* `document.querySelectorAll` 返回所有匹配的 Element 组成的 NodeList。它可以通过 `[].slice.call()` 把它转成 Array
* 如果匹配不到任何 Element，jQuery 返回空数组 `[]`，但 `document.querySelector` 返回 `null`，注意空指针异常。当找不到时，也可以使用 `||` 设置默认的值，如 `document.querySelectorAll(selector) || []`

> 注意：`document.querySelector` 和 `document.querySelectorAll` 性能很**差**。如果想提高性能，尽量使用 `document.getElementById`、`document.getElementsByClassName` 或 `document.getElementsByTagName`。

- [1.0](#1.0) <a name='1.0'></a> 选择器查询

  ```js
  // jQuery
  $('selector');

  // Native
  document.querySelectorAll('selector');
  ```

- [1.1](#1.1) <a name='1.1'></a> class 查询

  ```js
  // jQuery
  $('.class');

  // Native
  document.querySelectorAll('.class');

  // or
  document.getElementsByClassName('class');
  ```

- [1.2](#1.2) <a name='1.2'></a> id 查询

  ```js
  // jQuery
  $('#id');

  // Native
  document.querySelector('#id');

  // or
  document.getElementById('id');
  ```

- [1.3](#1.3) <a name='1.3'></a> 属性查询

  ```js
  // jQuery
  $('a[target=_blank]');

  // Native
  document.querySelectorAll('a[target=_blank]');
  ```

- [1.4](#1.4) <a name='1.4'></a> 后代查询

  ```js
  // jQuery
  $el.find('li');

  // Native
  el.querySelectorAll('li');
  ```

- [1.5](#1.5) <a name='1.5'></a> 兄弟及上下元素

  + 兄弟元素

    ```js
    // jQuery
    $el.siblings();

    // Native - latest, Edge13+
    [...el.parentNode.children].filter((child) =>
      child !== el
    );
    // Native (alternative) - latest, Edge13+
    Array.from(el.parentNode.children).filter((child) =>
      child !== el
    );
    // Native - IE10+
    Array.prototype.filter.call(el.parentNode.children, (child) =>
      child !== el
    );
    ```

  + 上一个元素

    ```js
    // jQuery
    $el.prev();

    // Native
    el.previousElementSibling;

    ```

  + 下一个元素

    ```js
    // next
    $el.next();

    // Native
    el.nextElementSibling;
    ```

- [1.6](#1.6) <a name='1.6'></a> Closest

  Closest 获得匹配选择器的第一个祖先元素，从当前元素开始沿 DOM 树向上。

  ```js
  // jQuery
  $el.closest(queryString);

  // Native - Only latest, NO IE
  el.closest(selector);

  // Native - IE10+
  function closest(el, selector) {
    const matchesSelector = el.matches || el.webkitMatchesSelector || el.mozMatchesSelector || el.msMatchesSelector;

    while (el) {
      if (matchesSelector.call(el, selector)) {
        return el;
      } else {
        el = el.parentElement;
      }
    }
    return null;
  }
  ```

- [1.7](#1.7) <a name='1.7'></a> Parents Until

  获取当前每一个匹配元素集的祖先，不包括匹配元素的本身。

  ```js
  // jQuery
  $el.parentsUntil(selector, filter);

  // Native
  function parentsUntil(el, selector, filter) {
    const result = [];
    const matchesSelector = el.matches || el.webkitMatchesSelector || el.mozMatchesSelector || el.msMatchesSelector;

    // match start from parent
    el = el.parentElement;
    while (el && !matchesSelector.call(el, selector)) {
      if (!filter) {
        result.push(el);
      } else {
        if (matchesSelector.call(el, filter)) {
          result.push(el);
        }
      }
      el = el.parentElement;
    }
    return result;
  }
  ```

- [1.8](#1.8) <a name='1.8'></a> Form

  + Input/Textarea

    ```js
    // jQuery
    $('#my-input').val();

    // Native
    document.querySelector('#my-input').value;
    ```

  + 获取 e.currentTarget 在 `.radio` 中的数组索引

    ```js
    // jQuery
    $('.radio').index(e.currentTarget);

    // Native
    Array.prototype.indexOf.call(document.querySelectorAll('.radio'), e.currentTarget);
    ```

- [1.9](#1.9) <a name='1.9'></a> Iframe Contents

  jQuery 对象的 iframe `contents()` 返回的是 iframe 内的 `document`

  + Iframe contents

    ```js
    // jQuery
    $iframe.contents();

    // Native
    iframe.contentDocument;
    ```

  + Iframe Query

    ```js
    // jQuery
    $iframe.contents().find('.css');

    // Native
    iframe.contentDocument.querySelectorAll('.css');
    ```

- [1.10](#1.10) <a name='1.10'></a> 获取 body

  ```js
  // jQuery
  $('body');

  // Native
  document.body;
  ```

- [1.11](#1.11) <a name='1.11'></a> 获取或设置属性

  + 获取属性

    ```js
    // jQuery
    $el.attr('foo');

    // Native
    el.getAttribute('foo');
    ```
  + 设置属性

    ```js
    // jQuery, note that this works in memory without change the DOM
    $el.attr('foo', 'bar');

    // Native
    el.setAttribute('foo', 'bar');
    ```

  + 获取 `data-` 属性

    ```js
    // jQuery
    $el.data('foo');

    // Native (use `getAttribute`)
    el.getAttribute('data-foo');

    // Native (use `dataset` if only need to support IE 11+)
    el.dataset['foo'];
    ```

**[⬆ 回到顶部](#目录)**

## CSS & Style

- [2.1](#2.1) <a name='2.1'></a> CSS

  + Get style

    ```js
    // jQuery
    $el.css("color");

    // Native
    // 注意：此处为了解决当 style 值为 auto 时，返回 auto 的问题
    const win = el.ownerDocument.defaultView;

    // null 的意思是不返回伪类元素
    win.getComputedStyle(el, null).color;
    ```

  + Set style

    ```js
    // jQuery
    $el.css({ color: "#ff0011" });

    // Native
    el.style.color = '#ff0011';
    ```

  + Get/Set Styles

    注意，如果想一次设置多个 style，可以参考 oui-dom-utils 中 [setStyles](https://github.com/oneuijs/oui-dom-utils/blob/master/src/index.js#L194) 方法

  + Add class

    ```js
    // jQuery
    $el.addClass(className);

    // Native
    el.classList.add(className);
    ```

  + Remove class

    ```js
    // jQuery
    $el.removeClass(className);

    // Native
    el.classList.remove(className);
    ```

  + has class

    ```js
    // jQuery
    $el.hasClass(className);

    // Native
    el.classList.contains(className);
    ```

  + Toggle class

    ```js
    // jQuery
    $el.toggleClass(className);

    // Native
    el.classList.toggle(className);
    ```

- [2.2](#2.2) <a name='2.2'></a> Width & Height

  Width 与 Height 获取方法相同，下面以 Height 为例：

  + Window height

    ```js
    // window height
    $(window).height();

    // 含 scrollbar
    window.document.documentElement.clientHeight;

    // 不含 scrollbar，与 jQuery 行为一致
    window.innerHeight;
    ```

  + Document height

    ```js
    // jQuery
    $(document).height();

    // Native
    const body = document.body;
    const html = document.documentElement;
    const height = Math.max(
      body.offsetHeight,
      body.scrollHeight,
      html.clientHeight,
      html.offsetHeight,
      html.scrollHeight
    );
    ```

  + Element height

    ```js
    // jQuery
    $el.height();

    // Native
    function getHeight(el) {
      const styles = this.getComputedStyle(el);
      const height = el.offsetHeight;
      const borderTopWidth = parseFloat(styles.borderTopWidth);
      const borderBottomWidth = parseFloat(styles.borderBottomWidth);
      const paddingTop = parseFloat(styles.paddingTop);
      const paddingBottom = parseFloat(styles.paddingBottom);
      return height - borderBottomWidth - borderTopWidth - paddingTop - paddingBottom;
    }

    // 精确到整数（border-box 时为 height - border 值，content-box 时为 height + padding 值）
    el.clientHeight;

    // 精确到小数（border-box 时为 height 值，content-box 时为 height + padding + border 值）
    el.getBoundingClientRect().height;
    ```

- [2.3](#2.3) <a name='2.3'></a> Position & Offset

  + Position

    获得匹配元素相对父元素的偏移

    ```js
    // jQuery
    $el.position();

    // Native
    { left: el.offsetLeft, top: el.offsetTop }
    ```

  + Offset

    获得匹配元素相对文档的偏移

    ```js
    // jQuery
    $el.offset();

    // Native
    function getOffset (el) {
      const box = el.getBoundingClientRect();

      return {
        top: box.top + window.pageYOffset - document.documentElement.clientTop,
        left: box.left + window.pageXOffset - document.documentElement.clientLeft
      }
    }
    ```

- [2.4](#2.4) <a name='2.4'></a> Scroll Top


  获取元素滚动条垂直位置。

  ```js
  // jQuery
  $(window).scrollTop();

  // Native
  (document.documentElement && document.documentElement.scrollTop) || document.body.scrollTop;
  ```

**[⬆ 回到顶部](#目录)**

## DOM Manipulation

- [3.1](#3.1) <a name='3.1'></a> Remove

  从 DOM 中移除元素。

  ```js
  // jQuery
  $el.remove();

  // Native
  el.parentNode.removeChild(el);

  // Native - Only latest, NO IE
  el.remove();
  ```

- [3.2](#3.2) <a name='3.2'></a> Text

  + Get text

    返回指定元素及其后代的文本内容。

    ```js
    // jQuery
    $el.text();

    // Native
    el.textContent;
    ```

  + Set text

    设置元素的文本内容。

    ```js
    // jQuery
    $el.text(string);

    // Native
    el.textContent = string;
    ```

- [3.3](#3.3) <a name='3.3'></a> HTML

  + Get HTML

    ```js
    // jQuery
    $el.html();

    // Native
    el.innerHTML;
    ```

  + Set HTML

    ```js
    // jQuery
    $el.html(htmlString);

    // Native
    el.innerHTML = htmlString;
    ```

- [3.4](#3.4) <a name='3.4'></a> Append

  Append 插入到子节点的末尾

  ```js
  // jQuery
  $el.append("<div id='container'>hello</div>");

  // Native (HTML string)
  el.insertAdjacentHTML('beforeend', '<div id="container">Hello World</div>');

  // Native (Element)
  el.appendChild(newEl);
  ```

- [3.5](#3.5) <a name='3.5'></a> Prepend

  ```js
  // jQuery
  $el.prepend("<div id='container'>hello</div>");

  // Native (HTML string)
  el.insertAdjacentHTML('afterbegin', '<div id="container">Hello World</div>');

  // Native (Element)
  el.insertBefore(newEl, el.firstChild);
  ```

- [3.6](#3.6) <a name='3.6'></a> insertBefore

  在选中元素前插入新节点

  ```js
  // jQuery
  $newEl.insertBefore(queryString);

  // Native (HTML string)
  el.insertAdjacentHTML('beforebegin ', '<div id="container">Hello World</div>');

  // Native (Element)
  const el = document.querySelector(selector);
  if (el.parentNode) {
    el.parentNode.insertBefore(newEl, el);
  }
  ```

- [3.7](#3.7) <a name='3.7'></a> insertAfter

  在选中元素后插入新节点

  ```js
  // jQuery
  $newEl.insertAfter(queryString);

  // Native (HTML string)
  el.insertAdjacentHTML('afterend', '<div id="container">Hello World</div>');

  // Native (Element)
  const el = document.querySelector(selector);
  if (el.parentNode) {
    el.parentNode.insertBefore(newEl, el.nextSibling);
  }
  ```

- [3.8](#3.8) <a name='3.8'></a> is

  如果匹配给定的选择器，返回true

    ```js
    // jQuery
    $el.is(selector);

    // Native
    el.matches(selector);
    ```

- [3.9](#3.9) <a name='3.9'></a> clone

  深拷贝被选元素。（生成被选元素的副本，包含子节点、文本和属性。）

  ```js
  //jQuery
  $el.clone();

  //Native
  //深拷贝添加参数'true'
  el.cloneNode();
  ```

- [3.1