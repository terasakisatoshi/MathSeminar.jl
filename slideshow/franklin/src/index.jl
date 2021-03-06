# # Introduction to Franklin.jl
#

# ---

# # Who am I ?
# ## Satoshi Terasaki
# - ゴマちゃんの飼い主

#    <img src="https://avatars2.githubusercontent.com/u/16760547?s=460&u=b9972126518803dfe4666a68b91bd4a3798f0a28&v=4" height="80">
# - [Interface 2020年6月号](https://interface.cqpub.co.jp/magazine/202006/) で Julia の特集を書きました．
#
#    <img src="https://interface.cqpub.co.jp/wp-content/uploads/MIF202006-scaled.jpg" height="180">

# ---

# # What is [Franklin.jl](https://github.com/tlienart/Franklin.jl) ? <img src="https://camo.githubusercontent.com/85517e47b497596f20eae9a49897d4de938976bd/68747470733a2f2f6672616e6b6c696e6a6c2e6f72672f6173736574732f696e6672612f6c6f676f46322e737667", height=150>
# - simple static site generator (SSG).
#    - コーディングや数学などの技術ブログを書く目的として.
#    - 軽量でページの読み込みが高速
# - 文法はベーシックなマークダウン.
#   - KaTeX ベースの数式レンダリングが可能
#   - `\mycommand{goma}{kyu}` のような $\LaTeX$ っぽいコマンドを自作可能
#   - コードブロックを評価しその出力を表示することができる.
#
# <pre>
# ```julia:hello
# println("Hello World") # ← こんな感じでマークダウンの中に挿入できる.
# ```
# </pre>


# ---

# # Some examples of websites using Franklin
# ### [README.md](https://github.com/tlienart/Franklin.jl#docs) から引用
#
# - Franklin.jl のドキュメント自体が Franklin を用いている. [source](https://github.com/tlienart/franklindocs)
# - [Julia のサイト](https://julialang.org) ブログなども含め Franklin をベースに構築されている.
#   - https://github.com/JuliaLang/www.julialang.org
# - [@cormullion's website](https://cormullion.github.io), the author of [Luxor.jl](https://github.com/JuliaGraphics/Luxor.jl),
# - MLJ's [tutorial website](https://alan-turing-institute.github.io/MLJTutorials/) which shows how Franklin can interact nicely with [Literate.jl](https://github.com/fredrikekre/Literate.jl)
# - [Tom Kwong's website](https://ahsmart.com/) author of [_Hands-on Design Patterns and Best Practices with  Julia_](https://www.amazon.com/gp/product/183864881X).
# - [Thibaut Lienart's website](https://tlienart.github.io).
#   - Franklin.jl のメンテナー

# ---

# # [MathSeminar.jl（ゴマの飼い主）](https://terasakisatoshi.github.io/MathSeminar.jl/)
# #### ギャラリー
# <img src="https://terasakisatoshi.github.io/MathSeminar.jl/assets/gallery/animation/code/output/lorenz.gif" height=200>　<img src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/135978/64395e6d-cfb7-9ef6-0b70-7661cfc123ee.png" height=140>
# <img src="https://qiita-image-store.s3.ap-northeast-1.amazonaws.com/0/135978/334798af-81fd-213a-58c5-a69e63897a4d.png" height=200>  <img src="https://terasakisatoshi.github.io/MathSeminar.jl/assets/gallery/animation/code/output/heart.gif" height=150>

# ---

# ## Why Franklin.jl ? (Part 1)
# #### Math $\times$ Programming
# - プログラミングを交えて"数学のコンテンツ"をインターネット上に書いていきたい気持ちがある．
# #### 要請
#   - 数学の概念の理解(実装を通して理解) $\times$ 実装の背景の理論(数学)
#     - 特に 数学 と Julia は相性がいい（そりゃそう）ので Julia 周りで
#   - 定義・定理・証明スタイルの文章を書きたい.
#     - 番号を付与したい. "定理 3.2.1 から次が成立する" みたいなのを書きたい
#     - いわゆる $\LaTeX$ の `\begin{theorem} ... \end{theorem}` 的なやつ
#       - 該当の定理にジャンプさせたい.
#   - 文章の中に コードを記述しそのコードの結果を表示しておきたい.
#     - GIF動画やグラフを対話的に
#   - 文章・ソースコードのメンテナンス・バージョン管理をしたい
#     - コードが変更されたら対応する出力の管理も容易にしておきたい.
#     - 数学書: 古くても現代に通じるものがある.
#     - 技術書: 一定の鮮度を保つ必要がある.
#   - 数学にウェイトをおいたオープンソース(?)を提供したい

# ---

# ## Why Franklin.jl ? (Part 2)
# #### Math $\times$ Programming
# - プログラミングを交えて"数学のコンテンツ"をインターネット上に書いていきたい気持ちがある．
# #### 要請
#   - 文章の中に コードを記述しそのコードの結果を表示しておきたい.
#     - GIF動画やグラフを対話的に
#   - 文章・ソースコードのメンテナンス・バージョン管理をしたい
#     - コードが変更されたら対応する出力の管理も容易にしておきたい.
#     - 数学書: 古くても現代に通じるものがある.
#     - 技術書: 一定の鮮度を保つ必要がある.

# ---

# ## Why Franklin.jl ? (Part 3)

# - Documenter.jl は？
#   - ちょっと物足りない. どちらかというとアレは Julia パッケージ, API仕様のドキュメントを管理するのがメイン.
# - Jupyter Notebook は？
#   - nbviewer, mybinder は便利.
#   - コードの共有には良いが文章メインの場合だとメリットがなさそう
# - Qiita/はてなブログは？
#   - 気軽, コメントなどフィードバックを得られる
#   - 数学書のように定義・定理・証明スタイルの文章が書けない
#   - カスタマイズが容易でない
#   - 単発記事を書くには良いが, それゆえに断片的な知識の提供になってしまいがち

# ---

# ## Why Franklin.jl ? (Part 4)
# - そもそも $\LaTeX$ つかえば？
#   - 可換図式とかマニアックな機能を使う必要がなさそう
#     - Visualization は Julia 側でやれば良い.
#   - 執筆環境構築(ダルイ, Overleaf? 知っとるわ)
#     - バージョン管理？
#     - コンパイルしたPDFをプッシュすればいいじゃん <- は？
#   - マークダウンの気軽さ, 可搬性は魅力的.
# - 紙媒体で出版すれば？
#   - 組み版・校正能力への不信感.
#   - 数式のフォントが見るに耐えない. 発狂しそうになる.
#   - こんなのを平気で印刷する $log(exp(x)) = x, cos^2\theta + sin^2\theta=1$
#   - なんか編集される．頑張って書いた部分が消えてる ``(´;ω;｀)``
#   - 出版社と著者の大人の事情が絡むので自分でホスティングしておきたい

# ---

# ## Why Franklin.jl ? (Part 5)
# - プログラミングが得意な人に数学という高級概念をの記述に耐えうる執筆基盤の発展を促進したい
#   - 便利な執筆環境は一般的なソフトウェアエンジニア用のためになっている.
#   - `MathJax`, `KaTeX` の登場でインターネット上で”やっと”発信できるようになっている.
# - 数学が得意な人にリッチな環境で数学的概念を記述・執筆をしてほしい
#   - 文字通り古めかしいフォントを使ってるサイトを運営している(そういうのに限って重要な事柄が書いてある.)
#   - 悲しいことに一般的なソフトのツール，メンテナンスのリテラシーを持っているわけではない.
#   - 計算機に興味を示さない人も多い(私とか).
#     - そーゆーひとたちにぃ計算機は理解の手助けになる便利なツールであることを知ってほしい.
# - 両方に興味があり能力に長ける人の育成を促進させたい.

# ---

# class: center, middle
# # Why Franklin.jl ? (Part 6)
# ## [In short, because I'm greedy.](https://julialang.org/blog/2012/02/why-we-created-julia/)
# So, if you are also a greedy, unreasonable, demanding programmer/reseacher, I want you to give it a try.
#
# <img src="https://camo.githubusercontent.com/85517e47b497596f20eae9a49897d4de938976bd/68747470733a2f2f6672616e6b6c696e6a6c2e6f72672f6173736574732f696e6672612f6c6f676f46322e737667", height=300>

# ---
# # Quick Start (Part1)
# ### Only at the first time
# ```julia-repl
# julia> import Pkg; Pkg.install("Franklin"); using Franklin
# julia> cd("path/to/your/workspace")
# julia> sitename = "Gomachan" # Anything you want
# julia> See: https://github.com/tlienart/FranklinTemplates.jl
# julia> templatename = "vela" # julia> for example
# julia> newsite(sitename, template=templatename)
# ```
# ### From the next time
# ```julia-repl
# julia> cd("path/to/your/workspace/Gomachan")
# julia> using Franklin
# julia> serve() # Or serve(port=8000)
# ```

# ---
# # Quick Start (Part2)

# Open your web browser and access [localhost:8000](http://localhost:8000/)
# ## Result
#
# <div style="text-align:center;">
#   <img height=300 src="https://user-images.githubusercontent.com/16760547/81135717-47c13e80-8f94-11ea-90e3-5e6b882cc46b.png">
# </div>

# ---

# ### Directory Structure
# ```
# $ tree -L 2
# .
# ├── _assets # ユーザーが追加するファイル（画像やコードなど）
# ├── _css # 見栄えをよくする
# │   ├── franklin.css　
# │   └── vela.css
# ├── _layout # ページレイアウトを編集
# |   |   (一部略)
# │   ├── head.html # ページのリンクの追加など基本的にこの中をいじれば良い
# │   └── page_foot.html
# ├── _libs # 必要に応じてJSライブラリを追加
# ├── config.md # 設定ファイル
# ├── index.md # ホーム
# ├── menu1.md # サンプル１
# ├── menu2.md # サンプル２
# └── menu3.md # サンプル３
# ```

# ---

# # Syntax (Markdown)
# - 普段 Qiita, はてなブログ, Jupyter Notebook 書いてるのであればすぐ慣れる.
# - 数式もドルマークで囲んで書けば良い.
# ### Examples
# - `$(x+y)^2 = (x^2 + 2xy + y^2)$` will give: $(x+y)^2 = (x^2 + 2xy + y^2)$
# - `$$\sum_{k=1}^n k^2 = \frac{1}{6}n(n+1)(2n+1)$$` will give:
# $$
# \sum_{k=1}^n k^2 = \frac{1}{6}n(n+1)(2n+1)
# $$

# ---

# # Syntax (Julia Code)
# ## Inserting code
# <img height=100 src="https://user-images.githubusercontent.com/16760547/81142688-3c2d4200-8fab-11ea-86c6-a6320dbd03e7.png">
# ### With live evaluation
# <img height=100 src="https://user-images.githubusercontent.com/16760547/81142973-e6a56500-8fab-11ea-8407-bbd312dae5a4.png">
# will give

println("Live Evaluation")


# ---

# # Plots
# <img height=150 src="https://user-images.githubusercontent.com/16760547/81143519-fcfff080-8fac-11ea-915f-942824be4762.png">
#
# will give:

using Plots
using Distributions
d = Normal(0, 1)
p = histogram(rand(d, 5000), normalize=:pdf)
p = plot!(p, x->pdf(d, x))
savefig(p, "hist.png") # hide

# <img height=150 src=hist.png>

# ---

# # Inserting Raw HTML
# You can inject raw HTML by fencing it with `~~~...~~~` .
# ### Example (Plotly)
# - See [Work with Plotly](https://franklinjl.org/extras/plotly/) for more details
# <img height=300 src="https://user-images.githubusercontent.com/16760547/81144177-7c41f400-8fae-11ea-91ad-20d181aadb89.png">

# ---

# # Inserting Raw HTML (via Julia code block)
#
# <img height=300 class="center" src="https://user-images.githubusercontent.com/16760547/81147039-6fc09a00-8fb4-11ea-9d6f-87bd97042f4e.png">
#
# ### See more concrete example:
#  - [gallery/plotlyjs3.md](https://github.com/terasakisatoshi/MathSeminar.jl/blob/master/gallery/plotlyjs3.md)
#  - [programming/sympy.md](https://github.com/terasakisatoshi/MathSeminar.jl/blob/master/programming/sympy.md)

# ---

# # More HTML (CSS, Div blocks)
#  you can use `@@divname ... @@` which will wrap the content in a `<div class="divname"> ... </div>` block
# <img height=400 src="https://user-images.githubusercontent.com/16760547/81149499-46eed380-8fb9-11ea-8f36-b85faa999b1a.png">

# ---

# # $\LaTeX$-like commands
# - Franklin allows the definition of commands using a LaTeX-like syntax. This can be particularly useful for repeating elements or styling inside or outside of maths environment.
#
# - To define a command, you must use the following syntax:
# #### Syntax
#   ```
#     \newcommand{\name}{num of arguments}{contents}
#   ```
# #### Usage

# - define command
#   ```
#     \newcommand{\statement}[2]{
#     @@!#1 \\
#     !#2
#     }
#   ```
#
# - call
#   `\statement{theorem}{ゴマちゃん可愛い}`
#

# ---

# # Advanced Topics
# ## Numbered Theorem
# ## Interactive Plot
# ## Deploying your website
# ---
# # Numbered Theorem
# - We can increment theorem number automatically
# <pre>
# \definition{}{(標本平均, 標本分散)}{...} <br>
# \prop{}{}{...}
# </pre>
# <img height=400 src="https://user-images.githubusercontent.com/16760547/81153289-bbc40c80-8fbd-11ea-886e-520823a592d9.png">
#

# ---

# # Interactive Plot
# ## JSXGraph.jl
# - This package aims to help generate JSXGraph code from Julia code that can then be plugged in a statically served website
# - Official documentation [JSXGraphWeb](https://tlienart.github.io/JSXGraphWeb/)
# - How to use on webpage built with Franklin [gallery/jsxgraph/](https://terasakisatoshi.github.io/MathSeminar.jl/gallery/jsxgraph/)
# <img height=300 src=https://user-images.githubusercontent.com/16760547/81154713-23c72280-8fbf-11ea-884e-924c9441b924.png>

# ---

# ## Deploying your website 
# ### Pushing `__site` via `Franklin.publish`
# - Franklin.publish をするとローカルの `__site` をリポジトリにプッシュしてそれを反映することが可能
#   - オススメしない. 
#     - リポジトリ直下のファイルなども全て add してプッシュされる（笑）
#     - なんかの秘密鍵 push しちゃったな会話を聞いた（闇）
# ### Using GitHub Actions (オススメ)
# - Follow the instruction below:
#   - [Deploying your website](https://franklinjl.org/workflow/deploy/index.html)
#   - https://github.com/tlienart2/tlienart2.github.io

# ---

# # まとめ
# - Franklin.jl で Website 作り方を紹介しました.
# - 質問は Julia 公式 Slack の `franklin` で（英語で）聞ける.
#   - メンテナーの方はすごく優しい.
# - コントリビュート歓迎らしいよ
#   - https://github.com/tlienart/Franklin.jl/issues/404
# 