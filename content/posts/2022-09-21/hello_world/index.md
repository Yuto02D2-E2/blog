---
title: "hello world"
date: 2022-09-21T18:27:20+09:00
cover:
  image: "images/cover.png"
  caption: "これはcover imageです."
summary: "動作確認のためのテストページです"
categories: "blog"
tags:
- "helloworld"
- "test"
---

hello world!!!

これは，テスト記事です．

ちなみに，上にあるやつはTable of Contents;ToC(目次)です．
hugoが勝手に作ってくれて便利ですね．

# heading 1 test
## heading 2 test
### heading 3 test
#### heading 4 test
##### heading 5 test
###### heading 6 test

## emoji test
:smile:
:sleeping:
:fire:
:poop:
:+1:
:-1:
:v:
:link:
:heavy_check_mark:
:jp:
:warning:
:mag:
:eyes:

> ref: <https://www.webfx.com/tools/emoji-cheat-sheet/>

## list test
- list item
  - sub list item
    - sub sub list item
  - sub list item
    - sub sub list item
1. list item
2. sub list item
3. sub sub list item

チェックリストも書けるよ
- [ ] in progress
- [x] done

## table test
|aa|bb|gg|
|:-:|:-:|:-:|
|cc|dd|hh|
|ee|ff|ii|

## 折りたたみ
<details>
<summary>折り畳み(click here)</summary>
これは折り畳みのテスト
</details>

## reference test
これは [^1] からも明らかである

外部リンク？も貼れる
[click here][10]

## math test
mathjaxというライブラリを使ってレンダリング？してるんだけど，このmathjaxというやつがmarkdownと相性が悪くてエラーを消すのが大変だった．

今調べてみたら，mathjax以外にもkatexというのがあるっぽい．

今はちゃんとインラインモードとスタンドアロンモード両方使える

これは $ F(x)= \sum_{n=1}^{N} \frac{1}{N} $ インラインtexです

これはスタンドアロンモード
$$
  \left( \int_0^\infty \frac{\sin x}{\sqrt{x}} dx \right)^2 =
  \sum_{k=0}^\infty \frac{(2k)!}{2^{2k}(k!)^2} \frac{1}{2k+1} =
  \prod_{k=1}^\infty \frac{4k^2}{4k^2 - 1} = \frac{\pi}{2}
$$

Inline : $ y = \int_0^1 {1\over x} dx $

Standalone: $$ y = \int_0^1 {1\over x} dx $$

$$
 \begin{bmatrix}
  a & b \\
  c & d \\
  \end{bmatrix}
$$

<div>
  $$
  \begin{bmatrix}
  a & b \\
  c & d \\
  \end{bmatrix}
  $$
</div>

## code block test
### feature
- シンタックスハイライト，行番号，コピーボタン
```python
def echo(msg: str) -> None:
    print("msg:", msg)
    return

if __name__ == "__main__":
    echo("hello, bob")
```
`$ python -m venv venv`

## shortcode test
twitter記事の埋め込みとか出来る．
{{< tweet user="SanDiegoZoo" id="1453110110599868418" >}}

他にも`layouts/shortcodes/*.html`に追加すれば好きなものを自作できる．

[^1]: これは出典です[https://google.com]

[10]: https://google.com/

> end of post. thanks for reading
