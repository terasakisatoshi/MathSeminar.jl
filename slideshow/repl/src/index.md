class: center, middle

# REPL で遊ぼう

---

# REPL で遊ぶとは？

<img width=1000 src=https://user-images.githubusercontent.com/16760547/146361937-9c5f97a3-f316-406b-82fa-e3629bbf92f3.png>

この画面でいろんなものを表示させること

---

# REPLでできると良いこと

- Jupyter などWeb環境がなくても使える.
- 単純にレトロな感じで面白い.
- 思ったよりも面白い.
- 今回は提供されているパッケージや小ネタをいっぱい用意した.

---

# 小ネタ: バナーの表示

```julia
julia> Base.banner()
               _
   _       _ _(_)_     |  Documentation: https://docs.julialang.org
  (_)     | (_) (_)    |
   _ _   _| |_  __ _   |  Type "?" for help, "]?" for Pkg help.
  | | | | | | |/ _` |  |
  | | |_| | | | (_| |  |  Version 1.7.0 (2021-11-30)
 _/ |\__'_|_|_|\__'_|  |  Official https://julialang.org/ release
|__/                   |

```

- ちなみに 🍌 はバナナ. REPL 上でも表現できる.

---

# バナナの Emoji 🍌 はどう入力するの?

- わからないことがあれば `? キーワードで` を入力

```julia
julia> ? # ここで ? を入力しEnterを押す. その後 🍌 を貼る:
help?> 🍌
"🍌" can be typed by \:banana:<tab>

search:

Couldn't find 🍌
Perhaps you meant !, %, &, ', *, +, -, /, :, <, >, \, ^, |, ~, ÷, π, ℯ, ∈, ∉, ∋, ∌ or ∘
  No documentation found.

  Binding 🍌 does not exist.

```

-  `\:banana:` と REPL で入力してから TAB キーを押す.

---

# Preview Markdown

- REPL 上で Markdown をプレビューできる.

```julia
julia> using Markdown: parse_file
julia> # あらかじめ README.md を作っておく
julia> parse_file("README.md")
```

- 例: JuliaLang の README.md の一部:

<center>
  <img width=550 src=https://user-images.githubusercontent.com/16760547/146624312-9d14c428-a411-4ecb-91fd-11bd1e2e5ad8.png>
</center>

---

# [In-REPL pager for Markdown](https://discourse.julialang.org/t/in-repl-pager-for-markdown/51768)

- 長い文章があってスクロールをする体験をしたい場合は下記のように `less` 関数を定義する. See Julia Discourse:
  - [In-REPL pager for Markdown](https://discourse.julialang.org/t/in-repl-pager-for-markdown/51768)

```julia
julia> using Markdown

julia> function InteractiveUtils.less(md::Markdown.MD)
           withenv("PAGER" => "less -R -f") do
               file = tempname()
               open(io -> Markdown.term(io, md), file, "w")
               less(file)
               rm(file)
           end
       end

julia> Markdown.parse_file("README.md") |> less
```

- `less` を自前で一から実装したくない人は次のスライドへ ->

---

# [TerminalPager.jl](https://github.com/ronisbr/TerminalPager.jl)


```julia
julia> using TerminalPager: less
julia> using Markdown: parse_file
julia> parse_file("README.md") |> less
```

- 矢印キー `←, ↓, ↑, →` or `h,j,k,l` で上下左右にスクロールできる. 終了する際は `q` を押す.

<center>
  <img height=300 src=https://user-images.githubusercontent.com/16760547/146623784-ace399d7-7a9b-4829-b856-f3cf812b1671.png >
</center>

---

# [UnicodePlots.jl](https://github.com/JuliaPlots/UnicodePlots.jl)

<img width=900 src=https://user-images.githubusercontent.com/16760547/146363503-c1db66bf-cfae-4333-9df3-dc524dc1f4c2.png>

---

# [UcicodeGraphics.jl](https://github.com/rafaqz/UnicodeGraphics.jl)

<img width=400 src=https://user-images.githubusercontent.com/16760547/146365598-3e82b86b-8027-4768-9594-cb726e77aa1d.png>

---

# [UnicodeFun.jl](https://github.com/SimonDanisch/UnicodeFun.jl)


- 　$\LaTeX$ フォーマットを Julia が対応するUnicodeへ変換する. (できないものもある)

```julia
julia> using UnicodeFun

julia> raw"\zeta(s)" |> to_latex
"ζ(s)"
```

---

# [OhMyREPL.jl](https://github.com/KristofferC/OhMyREPL.jl)

- 関数のシンタックスハイライトしてくれる. 色づけは [Crayons.jl](https://github.com/KristofferC/Crayons.jl) でできる.

<img width=600 src=https://user-images.githubusercontent.com/16760547/146663802-5b94589c-53a5-4621-9c20-b89cc9f6ddca.png>

---

# [TerminalClock.jl](https://github.com/AtelierArith/TerminalClock.jl)

- 現在時刻を表示する. 自作パッケージ

<img width=600 src=https://raw.githubusercontent.com/AtelierArith/TerminalClock.jl/main/readme_assets/stopwatch.gif>

- ストップウォッチや，タイマー機能もある.
- 文字盤はカスタムすることが可能.

---

# [Replay.jl](https://github.com/AtelierArith/Replay.jl)

- 実行手順を再生してくれる. 自作パッケージ.

<center>
  <img width=600 src=https://user-images.githubusercontent.com/16760547/146371375-7032b3db-89f2-42f7-ab93-2d84273eb62b.gif>
</center>

🎉

---

## ちなみに

ロゴを[プルリク](https://github.com/AtelierArith/Replay.jl/pull/7)でいただくことができました. ありがとうございます！

<img src=https://raw.githubusercontent.com/AtelierArith/Replay.jl/main/docs/src/assets/logo.svg>

ダークモード

<img src=https://raw.githubusercontent.com/AtelierArith/Replay.jl/main/docs/src/assets/logo-dark.svg>

---

# [Sixel.jl](https://github.com/johnnychen94/Sixel.jl) + [ImageInTerminal.jl](https://github.com/JuliaImages/ImageInTerminal.jl)

- SixelGraphics 対応ターミナルでできる. 
- Plots.jl の描画など他の応用例は [Qiita](https://qiita.com/SatoshiTerasaki/items/3ea9750069e1d631aff7) に書いた.

<center>
  <img width=600 src=https://user-images.githubusercontent.com/16760547/146372066-6ec58233-38b0-4a7c-aa18-01712a6eea5b.png>
</center>

---

# [VideoInTerminal.jl](https://github.com/IanButterworth/VideoInTerminal.jl)

まだ野良パッケージらしいが面白い. 矢印キーで画像を遷移できる.
<center>
  <img width=500 src="https://raw.githubusercontent.com/IanButterworth/VideoInTerminal.jl/main/mri_example.png">
</center>

---

# [Animated Unicode Plots with Julia](https://mdneuzerling.com/post/animated-unicode-plots-with-julia/)

- David Neuzerling さんの作品

<center>
  <img width=500 src=https://mdneuzerling.com/img/julia-animate.gif>
</center>

---

# [Let it snow()](https://discourse.julialang.org/t/let-it-snow/72950)

- Ian Butterworth さんの作品 Julia Discourse より
  - [ソースは公開されている](https://discourse.julialang.org/t/let-it-snow/72950)

<center>
  <img width=500 src=https://aws1.discourse-cdn.com/business5/uploads/julialang/original/3X/a/0/a07fe4045ac536651537252f6c51b5b1e5a5236a.gif>
</center>

---

# まとめ

- Julia の REPL は思ったよりもポテンシャルがある.
- REPL 芸は結構ウケが良い.
