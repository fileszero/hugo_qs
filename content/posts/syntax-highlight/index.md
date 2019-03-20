---
title: "Syntax Highlight"
date: 2019-03-20T16:12:35+09:00
draft: false
---

## Syntax Highlightのテスト

### バッククオート"```js"で囲む
```js
function main(){
    if(true){
        console.log("hello world");
    }
}
```
### ショートコード {{</* highlight js "linenos=inline, linenostart=1" */>}} で囲む
{{< highlight js "linenos=inline, linenostart=1" >}}
function main(){
    if(true){
        console.log('Hello world');
    }
}
{{< / highlight >}}
