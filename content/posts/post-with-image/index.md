---
title: "Post With Image"
date: 2019-03-20T13:16:09+09:00
draft: false
---

このコマンドで作成。
```
hugo new posts/post-with-image/index.md
```
### short code
layouts\shortcodes\img.htmlを追加。こんな感じで使います。
```
{{</* img src="ai_computer_sousa_robot.png" cmd="Resize" size="10x" title="ろぼ" /*/>}}
```
#### 使用例
{{< img src="ai_computer_sousa_robot.png" cmd="Resize" size="10x" title="ろ"/>}}
{{< img src="ai_computer_sousa_robot.png" cmd="Resize" size="50x"  title="ろぼ"/>}}
{{< img src="ai_computer_sousa_robot.png" cmd="Resize" size="100x" title="ろぼっ"/>}}
{{< img src="ai_computer_sousa_robot.png" cmd="Resize" size="240x" title="ろぼっと"/>}}
