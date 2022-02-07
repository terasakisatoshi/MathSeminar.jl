class: center, middle

# Intro2Julia

---

# Julia とは

こんなことができる:

- Python や Ruby のように動的で書きやすい
- LLVM の JIT コンパイル方式によって動作し C/C++/Fortran のように高速に動作できる
- 数値計算だけでなく Web アプリも作れる汎用的であり

さまざまなプログラミング言語の良いところを取り入れた [欲張りな](https://julialang.org/blog/2012/02/why-we-created-julia/)言語

参考:
  - [Julia: A fresh approach to numerical computing](https://arxiv.org/pdf/1411.1607.pdf)
  - [Why We Created Julia](https://julialang.org/blog/2012/02/why-we-created-julia/)
    - Julia開発者らのブログと論文
  - [なぜ僕らはJuliaを作ったか](https://www.geidai.ac.jp/~marui/julialang/why_we_created_julia/index.html)
    - 有志による日本語訳

---

# Julia の応用先

- この欲張りなプログラミング言語は数値計算を必要とする科学者に愛され
MIT, Stanford, Berkeley, CMU をはじめとする 1500 の大学で Julia を使った講義が行われている.
- 学術の分野ではもちろん商用利用でも使い始められている.

参考: 
  - TECHBLITZ からの記事: [Python並みに使いやすくC言語並みに早く。応用性抜群のプログラミング言語を支えるJulia Computing](https://techblitz.com/julia-computing/)
  - [Pharmaceutical Development](https://juliacomputing.com/case-studies/pfizer/)
  - [Why Menlo Ventures Invested in Julia Computing](https://medium.com/@timtullydevnull/why-menlo-ventures-invested-in-julia-computing-e0e3633d85a5)


---

# 書籍

紙媒体のもので手元にあるだけでも下記のものがある.

- [Juliaプログラミングクックブック (オライリー・ジャパン)](https://www.oreilly.co.jp/books/9784873118895/)
- [1から始めるJuliaプログラミング (コロナ社)](https://www.coronasha.co.jp/np/isbn/9784339029055/)
- [基礎から学ぶJulia (エスシーシー)](https://www.scc-kk.co.jp/scc-books/b-418.html)
- [Julia量子プログラミング入門](https://www.amazon.co.jp/dp/%E4%B8%AD%E5%B1%B1-%E8%8C%82-ebook)
- [Juliaで作って学ぶベイズ統計学 (講談社)](https://www.kspub.co.jp/book/detail/5259801.html)

ちなみに

- [科学計算とPythonの研究 (CQ出版社)](https://interface.cqpub.co.jp/magazine/202006/) の特集にも解説がある.

---

# Web上の入門記事

- [Julia in Physics 2021 Online](https://akio-tomiya.github.io/julia_in_physics/)
- [Quantitative Economics with Julia](https://julia.quantecon.org/intro.html)
- [Think Julia: How to Think Like a Computer Scientist](https://benlauwens.github.io/ThinkJulia.jl/latest/book.html)
- [The Julia Programming Language(YouTube channle)](https://www.youtube.com/channel/UC9IuUwwE2xdjQUT_LMLONoA)
- [Introduction to Computational Thinking](https://computationalthinking.mit.edu/Spring21/)
- [Julia Data Science](https://juliadatascience.io/)

# オンラインコミュニケーション

- [#JuliaLang](https://twitter.com/hashtag/JuliaLang?src=hashtag_click) [#Julia言語](https://twitter.com/hashtag/Julia%E8%A8%80%E8%AA%9E?src=hashtag_click) をつけて質問すれば誰か答えてくれる
- [Slack](https://julialang.org/slack/)
- [Discourse](https://discourse.julialang.org/)
- [Zulip](https://discourse.julialang.org/t/come-join-the-julia-zulip-chat/36070)

---

# 個人的に好きなところ

- 数学的な概念を表現しやすい
  - Unicode 入力支援のおかげで論文や教科書に出てくる $\alpha, \hat{y}, x_1, A^a, \pi, \otimes$ をそっくりそのままかける.
  - `julia> α, ŷ, x₁, Aᵃ, π, ⊗` 🍌 
  - 🍌 ももちろんできる. (`\:banana:` の後で Tab を押す)
- まともなシンタックスでベクトル・行列を使ったコードがかける.  
- サイエンスにバックグラウンドがある人と交流ができる
- Jupyter Notebook や Pluto.jl など対話的環境を作れる
- 可視化ライブラリがいっぱい
- Python と Julia の相互運用(Python は Julia のライブラリ)
- 頑張ったらラズパイでも動かせる.
  - 動的な側面を持っているのにも関わらず C ぐらいのスピードは出せる.
- REPL はとてもリッチ

---

# みんな気に入ってくるかも？な側面

- 引数に型アノテーションをつけて意図しない型を持つ値を関数に渡させないようにできる.
  - 実行時にエラーを出す. (Python とは格が違う)
  - 関数の引数に型アノテーションつければ高速になるはウソ(つけなくてもよい)
    - [Type annotation make JIT compile faster?](https://discourse.julialang.org/t/type-annotation-make-jit-compile-faster/31906)
- プロジェクトのアクティベートで環境の分離
- Julia だけ入れればライブラリの依存関係は観光構築は全て Julia 側でマネージしてくれる. 
  - 追加で apt-get ... とか brew ... とかしなくても良いようになっている.
- パッケージの開発が容易
  - PkgTemplates.jl で実用的な雛形を作れる
- リッチなパッケージマネージャがついている
- テスト，ドキュメント生成などの現代的な実務開発にも耐えうる機能が使える

---

# Julia の悪いところ (とされている誤解)

- なぜか周りで使っている人が少ない（なぜ？）
  - 乱立しているパッケージマネージャー，フォーマッタ，ライブラリのデプロイ，型アノテーションに苦しみながら Python を使っている人を見ると気の毒に思えて仕方がない.
- 破壊的な変更やエラーがめっちゃ出る (既に過去の話)
  - v0.6 の時代は確かにそうだった. ライブラリのインストールやサンプルコードすらままならない時はあった.
  - 単に入門するのであれば LTS の v1.6 を使えば特に困らない. v1.x から言語仕様が固まったのでライブラリを作る側が頑張って安定させている.
  - ソースコードは公開されているので直してプルリクエストを送れば良い. 実現すればあなたはその分野でヒーローになれる.
- プレコンパイル/JITコンパイル のオーバヘッドが重い(改良の余地はある)
  - 1.6 までのアップデートでだいぶマシになった.
  - カスタム sysimage を作るとかこの機会に良いマシンを買うと経済を回すことができる.

---

# Julia の悪いところ (とされている誤解)

- クラスがない・オプジェクト指向で書きたい
  - (多重継承)継承を駆使できるほど人類は賢くない.
  - 大抵の場合は構造体と multiple dispatch の仕組みを組み合わせることで実現ができる.
    - 一回気持ちをリセットして[この解説](https://gist.github.com/terasakisatoshi/4a7d5339c6a3ca015a82fa03f390afb3) を5回読んでから批判し直すと良い.

- 名前空間の問題
  - `using XXX` によっていろんな識別子がロードされてしまう
    - `using XXX: a, b, c` のように書けば `a`, `b`, `c` だけを `XXX` からロードすることができる. Python での `from XXX import a, b, c` 相当.
    - 特定の識別子がどのパッケージから来たかは `@which` マクロで大まかに判断ができる.
  - module を使って名前空間を管理できるし 1 module 1 リポジトリぐらいの小規模で管理した方が気楽かもしれない.

---

# Julia の悪いところ (とされている誤解)

- 使っている仕事が見つからない
  - 既にあるソフトウェアを書き直すのは大変なので
  - 新規開発案件にアンテナを伸ばしてチャンスを伺う
  - GitHubで自分で例をいっぱい作れば良い
- 日本語の文献が少ない
  - この機会に英語を身につけましょう
  - 日本語で会話したい時は Connpass や Twitter で勉強会や雑談会がある
  - 公式ドキュメントに基づいた解説があると喜ぶ人多そう

