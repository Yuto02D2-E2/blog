---
title: "Site history"
url: "sitehistory"
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
---

# はじめに
このページでは，このブログサイトを作るまでの過程や選んだ技術，その選定理由などを書いている．
半分メモみたいな感じで書いてるので結構長くなってしまった．

# サイトを作るまでの色々
院試のためのTOEICの勉強が嫌すぎて，現実逃避がてら前から作りたいと思っていたブログサイトを作ることにした．結果的には英語のドキュメントをめちゃくちゃ読んだから良かったかもしれない．

[ホームページ](https://yuto02d2-e2.github.io/)は素のHTML,CSS,JSを書いて作ったが，頻繁に更新するブログサイトで毎回HTMLなど書いていられないので，Markdownで書きたい．

MarkdownをHTMLにビルドするフレームワークをググると
- Jekyll (Ruby)
- Nuxt.js, Next.js, Gatsby.js (React)
- Hugo (Go lang)

などがあるらしい．これらはSSG(Static Site Generator)と呼ばれるもので，他にはSSRやCSRなどがある．
これらのフレームワークで`*.md`ファイルを`*.html`ファイルにビルドして，静的サイトとしてデプロイするイメージ．

じゃあどれを選ぶかだけど，

ブログのために一からReactを勉強する気にならなかったので，Nuxt,Next,Gatsbyは却下．

残り二つはどっちでも良かったけど，一旦Jekyllにすることにした．

## Jekyllの環境構築
[Jekyllのdocs](http://jekyllrb-ja.github.io/docs/)が丁寧に書いてあったので(若干情報が古い気もするが)これを参考にしていく．

JekyllはRubyが必要なので，まずはRuby本体をインストール．WSLだとホットリロードが出来ないという記事を見た気がするので，ローカル(Windows10)にインストールする．
> ref:<br>
> <https://www.ruby-lang.org/ja/documentation/installation/>
> <https://rubyinstaller.org/downloads/>

インストーラを実行すると，ターミナルが起動して何をインストールするか入力要求される．`1,2,3`と入力しておいた．

次にGemを使ってJekyllをインストールする．GemはRubyのパッケージマネージャらしい．Rubyをインストールすると(比較的新しいRubyであれば)Gemも付いてくる．
> ref: <https://www.ruby-lang.org/ja/libraries/>

何も問題無く全てのインストールが完了．Jekyll docsのクイックスタートを試してみる
> ref: <http://jekyllrb-ja.github.io/docs/#説明>

普通に動いた．

次にtheme(テーマ)を探す．めちゃくちゃ沢山あるが，ピンと来るものに出会えない．

ひたすらググって，やっと[良い感じのやつ](https://adityatelange.github.io/hugo-PaperMod/)に巡り会えたと思ったらこれはHugoのthemeだった．

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
> ref:
> 1. <https://www.mingw-w64.org/downloads/#mingw-builds/>
> 2. <https://joho.g-edu.uec.ac.jp/joho/gcc_win/>

ここら辺は一応信用できそう．

1.から
>ref: <https://sourceforge.net/projects/mingw-w64/files/mingw-w64/mingw-w64-release/>

に飛ぶ．これをインストールすれば一件落着課と思いきや，今度はmingwがインストール出来ない．
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
> ref:
> <https://github.com/adityatelange/hugo-PaperMod>
> <https://github.com/adityatelange/hugo-PaperMod/wiki/Installation>

`hugo server -D`で動かしてみる．

良い感じ！

世界最速と謳うだけあって，ビルドがめちゃくちゃ早い．Jekyllだと数秒かかっていたビルドがHugoだと数百msecで終わるし，`hugo server`から`ctrl+c`で抜ける時もなんかHugoの方が早い．

インストール大変だったけど，Hugoのほうが高機能だし見た目もいいしHugoに決めた．

## Hugo + PaperMod themeを設定する
`hugo new site <site name>`で雛形を作った後は，色々設定する．
どこから手を付けていいのか訳が分からんけど，公式ドキュメントをちゃんと読んで，GitHubのサンプルとかを参考にしつつ弄っていく．ドキュメントは英語だけど，勉強だと思って頑張る．
> ref: <https://gohugo.io/documentation/>

まずは`config.yaml`について．
hugoのデフォルトはconfig.tomlだけど，PaperMod製作者の人がyaml推しなのでそれに従う．
設定項目がめちゃくちゃあるけど，とりあえず全部コメントアウトして，1つずつ確認していった．

`archetypes/default.md`は`hugo new post/hoge.md`コマンドで新規ファイルを作成した時のテンプレート．
デフォルトから若干変更した．複数のテンプレートを作ることも可能だが，やってない．

`layouts/`以下は何も書かなければデフォルト(つまり，theme以下の`layouts/`)が呼ばれるので，気に入らない部分だけ上書きする．404.html，head.html(独自cssの読み込み，texを使うためのjsの読み込み)，footer.html(コピーライト部分変更)とpost_meta.html(postのUpdate時刻を表示)を追加した．

`static/`以下には独自cssやlogo等のstaticなcssを配置する．
`assets/`との違いはよく分かっていないけど，とりあえずstaticだけにした(assetsは消した)<br>
ビルド後は`/`に展開されるっぽい(`$ hugo`でビルドして確認した．`public/`以下がビルド成果物)<br>
つまり，`static/images/logo.png`は`images/logo.png`で参照する．ややこしい．

`resouces/`はよく分からん．消しても`hugo server`したら生成される．なにこれ？

`content/posts/`以下に記事を書いていく．
`*mk`ファイルの先頭には，必ず`front matter`を記述する．これに基づいてtagとかtitleとか色々Hugoが勝手にやってくれる．
### front matterについて
- title: urlなどに使われるので，なるべく英語の方が良いかな
- date: hugo newした時刻が自動入力される．post上部のupdateなどに表示される
- cover:カバー画像
- summary: index.xmlやtagで検索した時のタイトル下に表示される文字列
- categories, tags:カテゴリーやタグで絞り込むためのもの．post下部にtag一覧が表示される
- draft: 下書きかどうか(bool)

## 最終的なディレクトリ構成と各ファイルの役割など
```plane
blog/
  ├.github/workflows/ci.yaml
  ├.vscode/ ->エディタの設定
  ├archetypes/ ->`hugo new`コマンドでpostを作成した時のテンプレート
  ├content/ ->blogのメインコンテンツ
    ├_index.md ->よく分からんけど一応置いてる．pythonの__init__.pyのイメージだけど間違ってるかも
    ├archives.md ->url:/blog/archives/にアクセスした時に表示される
    ├search.md ->url:/blog/search/にアクセスした時に表示される
    ├about_me.md ->url:/blog/aboutme/にアクセスした時に表示される
    ├site_history.md ->url:/blog/sitehistory/にアクセスした時に表示される
    └posts/
      ├YYYY-MM-DD-HH-MM-SS/
        ├title-1/ ->これが記事の最小単位
          ├index.md
          └images/
        ...
        └title-n/
          ├index.md
          └images/
  ├layouts/ ->themes/*以下に同じものがあって，必要な分だけこれで上書きしている
  ├static/ ->cssと(staticな)imageの置き場．build後はroot以下に展開される
  ├themes/PaperMod/ ->テーマ
  ├.gitmodules ->themeをgitのsub moduleとして登録しているので
  ├script.sh ->自分で作ったもの．
  ├config.yaml ->hugoの設定ファイル．全ての設定が書かれている
  └README.md
```

### 使用したコマンド
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

### レポジトリをcloneして新たな環境で始める時
```bash
$ git clone https://github.com/Yuto02D2-E2/blog.git
$ cd blog
$ sh script.sh
```


## デプロイする
調べた感じ，HugoのサイトはNetlifyでデプロイするのが人気らしいけど，一旦慣れているGitHub Pagesでデプロイする．不満があればNetlifyに乗り換えてもいいかなとは思っている．

デプロイ時は，GitHub Actionsを使用してCIを行う．GitHubのサイトに行って，Actionsタブから探すとHugo用のテンプレートがあったのでそのまま使った．ネット上にも`ci.yaml`は色々公開されてるけど(Hugoのdocs含め)少し古いやり方が多かったので，GitHub公式のテンプレートを使うのが一番賢い気がする．

## その他
Google AnalyticsとGoogle Search Console?を設定した．ホームページでも設定したけど未だによく分からん．

広告は今の所付ける予定無い．

今後はウェルカムページとか作りたい．以下はメモ．<br>
- ターミナル風の画面でwelcomeの文字が入力されてenter押されてメインページにリダイレクト的な
- ページ読み込みの度に演出したらうざいから、最初のアクセス時だけにしたい(どうやって？)
- キャッシュを利用して、最後に読み込まれてから30分以降たったら演出するとか？
- 演出部分はgifで作って、それだけのhtmlにjs埋め込んでindexにリダイレクトする？

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
- [ ] site_historyページに画像を貼りたい．
- [ ] READMEにコマンドの説明を書く？
- [ ] 記事を書く(本来の仕事)
- [ ] welcomeページ作成→動的でなんかすごい演出をtopページでやりたい
- [ ]

# おわりに
思ってた3倍くらい時間かかったけど，良い感じに出来たので満足．

<br>

> end of post. thanks for reading
