---
title: "Site history"
url: "info/sitehistory"
cover:
  image: "images/cover.png"
summary: "このブログサイトを作るまでの過程や選んだ技術，その選定理由など"
categories: "readme"
tags:
- "readme"
- "history"
- "memo"
- "blog"
- "markdown"
- "ssg"
- "jekyll"
- "ruby"
- "hugo"
- "go lang"
- "mingw-w64"
- "papermod-theme"
- "github pages"
- "github actions"
- "ci"
- "TODO"
draft: true
---

# はじめに
このページでは，このブログサイトを作るまでの過程や選んだ技術，その選定理由などを書いている．
半分メモみたいな感じで書いてるので結構長くなってしまった．

# サイトを作るまでの色々
院試のためのTOEICの勉強が嫌すぎて，現実逃避がてら前から作りたいと思っていたブログサイトを作ることにした．結果的には英語のドキュメントをめちゃくちゃ読んだから良かったかもしれない．

ブログといって思い浮かぶのは
- Qiita
- Zenn
- note
- はてなブログ
- FC2
- WIX
- WordPress

などだけど，これらを使うとなんかありきたりで面白くない．せっかくなので見た目とか機能を自分好みにカスタマイズして遊びたい．WordPressならカスタマイズとかは出来るだろうけど，自称エンジニア達のクソブログで検索結果が汚染されていて調べるのが大変そうなので却下．

しかし，[以前作成したホームページ](https://yuto02d2-e2.github.io/)のように素のHTML,CSS,JavaScriptを書くというのも大変．
ホームページと違い，頻繁に更新するブログサイトは最初の設定だけ頑張って，記事はMarkdownなどで手軽に書けるのが良い．
そこで，MarkdownをHTMLにビルドするフレームワークをググると
- Next.js, Gatsby.js (React)
- Nuxt.js (Vue)
- Jekyll (Ruby)
- Hugo (Go lang)

などがあるらしい．これらはSSG(Static Site Generator)と呼ばれるもので，他にはSSRやCSRなどがある．
SSGは，`*.md`ファイルを`*.html`ファイルにビルドして，静的サイトとしてデプロイするイメージ．(Reactのやつは動的にも出来るっぽい？)

じゃあどれを選ぶかだけど，

ブログのために一からReactやVueを勉強する気にならなかったので，Next,Gatsby,Nuxtは却下．

残り二つはどっちでも良かったけど，一旦(GitHub Pagesでも使われているし)Jekyllにすることにした．

## Jekyllの環境構築
[Jekyllのdocs](http://jekyllrb-ja.github.io/docs/)が丁寧に書いてあったので(若干情報が古い気もするが)これを参考にしていく．

JekyllはRubyが必要なので，まずはRuby本体をインストール．WSLだとホットリロードが出来ないという記事を見た気がするので，ローカル(Windows10)にインストールする．
> ref: <https://www.ruby-lang.org/ja/documentation/installation/><br>
> ref: <https://rubyinstaller.org/downloads/>

インストーラを実行すると，ターミナルが起動して何をインストールするか入力要求される．`1,2,3`と入力しておいた．

次にGemを使ってJekyllをインストールする．GemはRubyのパッケージマネージャらしい．Rubyをインストールすると(比較的新しいRubyであれば)Gemも付いてくる．
> ref: <https://www.ruby-lang.org/ja/libraries/>

何も問題無く全てのインストールが完了．Jekyll docsのクイックスタートを試してみる
> ref: <http://jekyllrb-ja.github.io/docs/#説明>

普通に動いた．

### themeが見つからない
次にtheme(テーマ)を探す．めちゃくちゃ沢山あるが，ピンと来るものに出会えない．
> ref: <http://jekyllrb-ja.github.io/docs/themes/><br>
> ref: <https://jekyllrb.com/showcase/>

### Hugoとの出会い
ひたすらググって，やっと[良い感じのやつ](https://adityatelange.github.io/hugo-PaperMod/)に巡り会えたと思ったらこれはHugoのthemeだった ．

しょうがないのでHugoの環境構築もして，設定がやりやすそうならHugoに変更する．

## Hugoの環境構築

まずはGo本体をインストールする．Ruby同様，ホットリロードが効かない説があったので，ローカルに入れる．
> ref: <https://go.dev/doc/install>

`$ go version`でインストール出来たか確認すると，`> go command not found`となった．
Windowsのシステム環境変数を確認してもPATHは通っているしなんで？と思ったら，ターミナルが開きっぱなしだった(PATHはターミナル起動時に読み込まれる)．ターミナルを再起動して確認すると
```plane
$ go version
go version go1.19.1 windows/amd64
```
となった．良かった．

次にHugoをインストールする．
brewが使えれば一番楽なのだろうけど，Winにはない(chocoとかscoopとかあるのはあるけど，微妙)なので，GitHubからcloneしてself buildする．公式でも，Winの場合はGitHubからfetchするのが推奨されている．
> ref: <https://github.com/gohugoio/hugo#build-and-install-the-binaries-from-source-advanced-install>

READMEに書かれている通りに実行する
```plane
$ mkdir $HOME/src
$ cd $HOME/src
$ git clone https://github.com/gohugoio/hugo.git
$ cd hugo
$ CGO_ENABLED=1 go install --tags extended
```

### エラー出た
```plane
.
.
.
github.com/bep/gowebp/internal/libwebp
cc1.exe: sorry, unimplemented: 64-bit mode not compiled in
github.com/bep/golibsass/internal/libsass
cc1.exe: sorry, unimplemented: 64-bit mode not compiled in
```
ググってみると，LOCALにPATHが通っているmingw(GCCコンパイラ)が32bit版であることが原因らしい．
mingwをインストールした当時(大学1年生の夏休み)は，アーキテクチャ？なにそれ？という感じで全くの無知だったからしょうがない．
64bit版を入れなおすことにする．

### mingw-w64のインストール
なんかどのサイトも微妙に違うところからインストールしててどれを信用していいのか分からん．
> 1. <https://www.mingw-w64.org/downloads/#mingw-builds/>
> 2. <https://joho.g-edu.uec.ac.jp/joho/gcc_win/>

ここら辺は一応信用できそう．

1.から
>ref: <https://sourceforge.net/projects/mingw-w64/files/mingw-w64/mingw-w64-release/>

に飛ぶ．これをインストールすれば一件落着かと思いきや，今度はmingwがインストール出来ない．
インストーラを起動して，利用規約とかに同意して，\<実行\>すると，`the file has been downloaded incorrectly`というエラーが出て落ちる．調べてみると，「インストーラを使うのは諦めて，手動インストールしろ」と書いてあったのでそうする．
> ref: <https://stackoverflow.com/questions/46455927/mingw-w64-installer-the-file-has-been-downloaded-incorrectly>

仕方が無いので，zipファイルダウンロードして解凍してC:/以下に移してPATHを通す(インストーラの仕事を手作業でやる)

zipファイルはこれ[mingw-w64/x86_64-8.1.0-posix-seh-rt_v6-rev0](https://sourceforge.net/projects/mingw-w64/files/Toolchains%20targetting%20Win64/Personal%20Builds/mingw-builds/8.1.0/threads-posix/seh/x86_64-8.1.0-release-posix-seh-rt_v6-rev0.7z)を使う．

64bit, latest version, posix, sehという組み合わせ．posix, sehはインストーラを使った時に自動選択されていたからこれを選んだ．

上記の[source forgeのページ](https://sourceforge.net/projects/mingw-w64/files/mingw-w64/mingw-w64-release/)で下にスクロールして`MinGW-W64 GCC-8.1.0`という部分から選択する．

zipを展開してPATHを通して確認する
```plane
$ gcc -v
Using built-in specs.
COLLECT_GCC=C:\mingw64\bin\gcc.exe
COLLECT_LTO_WRAPPER=C:/mingw64/bin/../libexec/gcc/x86_64-w64-mingw32/8.1.0/lto-wrapper.exe
Target: x86_64-w64-mingw32
Configured with: ../../../src/gcc-8.1.0/configure --host=x86_64-w64-mingw32 --build=x86_64-w64-mingw32 --target=x86_64-w64-mingw32 --prefix=/mingw64 --with-sysroot=/c/mingw810/x86_64-810-posix-seh-rt_v6-rev0/mingw64 --enable-shared --enable-static --disable-multilib --enable-languages=c,c++,fortran,lto --enable-libstdcxx-time=yes --enable-threads=posix --enable-libgomp --enable-libatomic --enable-lto --enable-graphite --enable-checking=release --enable-fully-dynamic-string --enable-version-specific-runtime-libs --disable-libstdcxx-pch --disable-libstdcxx-debug --enable-bootstrap --disable-rpath --disable-win32-registry --disable-nls --disable-werror --disable-symvers --with-gnu-as --with-gnu-ld --with-arch=nocona --with-tune=core2 --with-libiconv --with-system-zlib --with-gmp=/c/mingw810/prerequisites/x86_64-w64-mingw32-static --with-mpfr=/c/mingw810/prerequisites/x86_64-w64-mingw32-static --with-mpc=/c/mingw810/prerequisites/x86_64-w64-mingw32-static --with-isl=/c/mingw810/prerequisites/x86_64-w64-mingw32-static --with-pkgversion='x86_64-posix-seh-rev0, Built by MinGW-W64 project' --with-bugurl=https://sourceforge.net/projects/mingw-w64 CFLAGS='-O2 -pipe -fno-ident -I/c/mingw810/x86_64-810-posix-seh-rt_v6-rev0/mingw64/opt/include -I/c/mingw810/prerequisites/x86_64-zlib-static/include -I/c/mingw810/prerequisites/x86_64-w64-mingw32-static/include' CXXFLAGS='-O2 -pipe -fno-ident -I/c/mingw810/x86_64-810-posix-seh-rt_v6-rev0/mingw64/opt/include -I/c/mingw810/prerequisites/x86_64-zlib-static/include -I/c/mingw810/prerequisites/x86_64-w64-mingw32-static/include' CPPFLAGS=' -I/c/mingw810/x86_64-810-posix-seh-rt_v6-rev0/mingw64/opt/include -I/c/mingw810/prerequisites/x86_64-zlib-static/include -I/c/mingw810/prerequisites/x86_64-w64-mingw32-static/include' LDFLAGS='-pipe -fno-ident -L/c/mingw810/x86_64-810-posix-seh-rt_v6-rev0/mingw64/opt/lib -L/c/mingw810/prerequisites/x86_64-zlib-static/lib -L/c/mingw810/prerequisites/x86_64-w64-mingw32-static/lib '
Thread model: posix
gcc version 8.1.0 (x86_64-posix-seh-rev0, Built by MinGW-W64 project)
```

やっとmingw64のインストールが終了した．

もう一度
`$ CGO_ENABLED=1 go install --tags extended`
を試すと，無事にHugoのインストールも完了．

Hugoのクイックスタートを試してみる．
> ref: <https://gohugo.io/getting-started/quick-start/>

themeを選択する部分で，さっき発見したやつを適用する
> ref: <https://github.com/adityatelange/hugo-PaperMod><br>
> ref: <https://github.com/adityatelange/hugo-PaperMod/wiki/Installation>

`hugo server -D`で動かしてみる．

良い感じ！！！

インストール大変だったけど，Hugoのほうが高機能だし見た目もいいしHugoに決めた．

## Hugo + PaperMod themeを設定する
`hugo new site <site name>`で雛形を作った後は，色々設定する．
どこから手を付けていいのか訳が分からんけど，公式ドキュメントをちゃんと読んで，GitHubのサンプルとかを参考にしつつ弄っていく．ドキュメントは英語だけど，勉強だと思って頑張る．
> ref: <https://gohugo.io/documentation/> <br>
> ref: <https://gohugo.io/getting-started/configuration/>

### config.yaml
まずは`config.yaml`について．
hugoのデフォルトはconfig.tomlだけど，PaperMod製作者の人がyaml推しなのでそれに従う．
設定項目がめちゃくちゃあるけど，とりあえず全部コメントアウトして，1つずつ確認していった．

### archetypes/
`archetypes/default.md`は`hugo new post/hoge.md`コマンドで新規ファイルを作成した時のテンプレート．
デフォルトから若干変更した．複数のテンプレートを作ることも可能だが，やってない．

### layouts/
`layouts/`以下は何も書かなければデフォルト(つまり，`themes/layouts/`)が呼ばれるので，気に入らない部分だけ上書きする．上書きする時は，`themes/layouts/`から`layouts/`にコピーしてきてそれを編集する．オリジナルのものは触らない．
#### 修正箇所
- `layouts/404.html`(顔文字を入れた)
- `layouts/_default/archives.html`(archivesページにsummary項目を追加)
- `layouts/_default/list.html`(profileModeでも記事一覧を表示するように変更)
- `layouts/partials/extend_head.html`(独自cssの読み込み，mathjax(js)の読み込み)
- `layouts/partials/footer.html`(コピーライト部分変更)
- `layouts/partials/post_meta.html`(postのUpdate時刻を表示)
- `layouts/partials/post_nav_link.html`(prevとnextが逆になってるのを修正)

### static/
`static/`以下には独自cssやlogo等のstaticなimageを配置する．
`assets/`との違いはよく分かっていないけど，とりあえずstaticだけにした(assetsは消した)<br>
ビルド後は`/`に展開されるっぽい(`hugo`コマンドでビルドして確認した．`public/`以下がビルド成果物)<br>
つまり，`static/images/logo.png`は`images/logo.png`で参照する．ややこしい．

#### 修正箇所(`static/css/custom.css`)
- フォント
- 見出しの飾りと余白
- スクロール演出

### content/
`content/_index.md`がindex.htmlに対応する(本当はモードによるけど，全ての場合に表示するように改造した)．<br>
`content/info/*`にはreadmeから飛べる，このサイトの情報が記載された記事が置いてある．<br>
普段は`content/posts/`以下に記事を書いていく．

`*.md`ファイルの先頭には，必ず`front matter`を記述する．これに基づいてtagとかtitleとか色々Hugoが勝手にやってくれる．
#### front matterについて
- title: urlなどに使われるので，なるべく英語の方が良いかな
- date: hugo newした時刻が自動入力される．post上部のupdateなどに表示される
- cover:カバー画像
- summary: index.xmlやtagで検索した時のタイトル下に表示される文字列
- categories, tags:カテゴリーやタグで絞り込むためのもの．post下部にtag一覧が表示される
- draft: 下書きかどうか(bool)

### other
`resouces/`はよく分からん．消しても`hugo server`したら生成される．なにこれ？

`.hugo_build.lock`もよく分からん．

## Hugo + PaperMod theme のお気に入りポイント
### Hugo
- 世界最速と謳うだけあって，ビルドがめちゃくちゃ早い．Jekyllだと数秒かかっていたビルドがHugoだと数百msecで終わるし，`hugo server`から`ctrl+c`で抜ける時もなんかHugoの方が早い．
- ドキュメントがしっかりしている
- PaperMod themeがある ← これが一番
### PaperMod theme
- 最低限の機能を持ちつつ，シンプルで良い感じの見た目
- カスタマイズも(それなりに)やりやすい
- (英語が多いけど)ググったら大抵の情報は得られるユーザーの多さ
- デフォルトのlight/darkテーマ切り替えがワンタップで行えて良い．(他のthemeだと，二回タップする必要があるのが多かった)
- カテゴリー，タグによる絞り込みや，検索機能などがデフォルトで付いてるの便利


## 使用したコマンド
```bash
$ hugo new site blog
$ cd blog
$ git init
$ git submodule add --depth=1 https://github.com/adityatelange/hugo-PaperMod.git themes/PaperMod

// settings: edit config.yaml(set theme) and or
// make posts: edit *.md files
$ hugo new posts/YYYY-MM-DD-HH-MM-SS/title/index.md --editor=code

// local test (-D option means draft:true)
$ hugo server -D

// deploy
$ git remote add origin https://github.com/Yuto02D2-E2/blog.git
$ git add --all
$ git commit -m "init repo"
$ git push -u origin main


// automation; make posts and push
$ sh script.sh
```

### レポジトリをcloneして新たな環境で書き始める場合
```bash
$ git clone https://github.com/Yuto02D2-E2/blog.git
$ cd blog
$ sh script.sh
```

## 快適な編集環境を作りたい
快適な環境を作るための労力は厭わない精神で色々と設定した．

主に
- vscode
- shell script
- github actions ci

の３点．

### VSCode
一番使い慣れているエディタ．今では[vscode](https://azure.microsoft.com/ja-jp/products/visual-studio-code/)+[vim-keybind](https://marketplace.visualstudio.com/items?itemName=vscodevim.vim)の組み合わせが無いと生きていけない体になってしまった．

既に色々と設定してきたが，特にエディタのカラー(`Solarized Light`)はとても気に入っている．白だと暗い時に眩しいし，黒だと明るい場所で見えにくいが，この色だと暗い場所でも明るい場所でも見えやすく，目も疲れにくい．素晴らしい．
![screenshot](https://raw.githubusercontent.com/ryanolsonx/vscode-solarized-theme/master/screenshots/light-full.png)
> ref: <https://marketplace.visualstudio.com/items?itemName=ryanolsonx.solarized>

このプロジェクトに向けてやったこととしては，新たにmarkdown系の拡張機能をいくつか入れた．導入したものは`.vsocde/extensions.json`に記載したので，新たな環境にcloneしてvscodeでそのディレクトリを開くとポップアップでおすすめされるようにしてある．

新たに導入した拡張機能の内，メインのものは以下
- markdown-all-in-one：なんか色々できるらしい．まだ使いこなせてない
- markdownlint：markdownの文法エラーを表示，`ctrl+.`でfixしてくれる．過剰な分はsettings.jsonでignoreする
- paste-image：markdownファイルがアクティブな状態で`ctrl+alt+v`を押すと，クリップボード内の画像を`./images/YYYY-MM-DD-HH-MM-SS.png`に保存してmarkdownにそこまでのパスを入力してくれる

それから，`.vscode/settings.json`に記載したhtmlの自動フォーマットを全offにするのも必須．`.html`に書かれたHugo独自の記法が変にフォーマットされてエラーが出るのでmarkdownのみフォーマットするようにする．

### Shell Script
いつものやつ．記事の作成とGitHubへのpushをするスクリプトを書いた．日付を打つのとか結構めんどいからとても便利．

### GitHub Actions CI
デプロイ時は，GitHub Actionsを使用してCIを行う．ローカルでビルドして，GitHubで`public/`を公開する設定にしてもいいけど，`*md`ファイルをそのままpushして向こうでビルドからデプロイまでしてくれる方が良いと思う．

CIのjobを定義したyamlファイルは，GitHubのサイトでActionsタブから探すとHugo用のテンプレートがあったので，それをそのまま使った．ネット上にも`ci.yaml`は色々公開されてるけど(Hugoのdocs含め)少し古いやり方が多かったので，GitHub公式のテンプレートを使うのが一番賢い気がする．

#### 新しいGitHub Actions for GitHub Pages
> ref: <https://github.blog/changelog/2022-07-27-github-pages-custom-github-actions-workflows-beta/> <br>
> ref: <https://github.com/actions/starter-workflows/blob/main/pages/hugo.yml>

`peaceiris/actions-gh-pages@v3`ではなく
- `actions/configure-pages@v2`
- `actions/upload-pages-artifact@v1`
- `actions/deploy-pages@v1`

を使っているのがポイント．これにより，`gh-pages`ブランチを使わずにmainブランチのみで運用できるっぽい．英語読めないから間違ってるかも．

## デプロイする
調べた感じ，HugoのサイトはNetlifyでデプロイするのが人気らしいけど，一旦慣れているGitHub Pagesでデプロイする．不満があればNetlifyに乗り換えてもいいかなとは思っている．

## その他
Google AnalyticsとGoogle Search Console?を設定した．ホームページでも設定したけど未だによく分からん．

アフィカス記事は嫌いなので，広告は付けない(というかこんなブログは多分審査に通らないから付けられない)．

# TODO
- [x] themeを決める
- [x] logoを決めて設定
- [x] faviconを作って設定
- [x] CSS系
  - [x] 各記事のcover画像を設定したい
  - [x] fontを変えたい(cssが反映されない)．どうすればいいのでしょうか？
  - [x] heading*の前に飾りを付けたい
- [x] sns共有リンク集(フッターの上にあるやつ)を消すか，twitterだけにしたい
- [x] CI.yamlを完成させる(今中途半端)
- [x] 一旦github pagesでデプロイしてみる
- [x] script.shを作る(記事の作成，更新，githubへのpush等を行うシェルスクリプト)
- [x] READMEにdemo(トップページのスクショ)を貼る→画像はどこに置けばいいんでしょうか．static?
- [x] フォルダの整理
  - [x] archetypes:hugo newする時のテンプレ．vscodeのsnippetでも代用できるけどどうしましょう
  - [x] assets:css置いてるけどここでいいのかな？→消した
  - [x] layouts:themeの設定を必要な部分だけオーバーライドする．
  - [x] static:css/,images/の置き場．config.yamlとかから相対パスでアクセス出来る．buildしたらroot以下にstatic/*が展開されてるっぽい?
- [ ] site_historyページに画像を貼りたい
- [ ] READMEにコマンドの説明を書く？
- [ ] 記事を書く(本来の仕事)
- [x] welcomeページ作成→動的でなんかすごい演出をtopページでやりたい→これはblogサイトじゃなくてホームページの方でやる

# おわりに
思ってた3倍くらい時間かかったけど，良い感じに出来たので満足．

<br>

> end of post. thanks for reading
