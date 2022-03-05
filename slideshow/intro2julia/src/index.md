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
  - Unicode 入力支援のおかげで論文や教科書に出てくる $\beta, \hat{y}, x_1, A^a, \pi, \otimes$ をそっくりそのままかける.
  - `julia> β, ŷ, x₁, Aᵃ, π, ⊗`
  - 🍌 ももちろんできる. (`\:banana:` の後で Tab を押す)
- まともなシンタックスでベクトル・行列を使ったコードがかける.  
- サイエンスにバックグラウンドがある人と交流ができる
- Jupyter Notebook や Pluto.jl など対話的環境を作れる
- 可視化ライブラリがいっぱい
- Python と Julia の相互運用ができる (Python は Julia のライブラリ)
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
- Julia だけ入れればライブラリの依存関係は環境構築は全て Julia 側でマネージしてくれる. 
  - 追加で `apt-get ...` とか `brew ...` とかしなくても良いようになっている.
- パッケージの開発が容易
  - [PkgTemplates.jl](https://github.com/invenia/PkgTemplates.jl) で実用的な雛形を作れる
- リッチなパッケージマネージャがついている
- テスト，ドキュメント生成などの現代的な実務開発にも耐えうる機能が使える

---

# Can we use Julia in production ?

--

Me "I believe we can !!!"

--

Other people "Really ???"

--

Me "I believe we can !!!"

--

Other people "Really ???"

--

Me "Come on !!! 😩 You're so mean"


---

# 巷でよく言われていること

- 使える人が少ない
  - そうかも
- サクッとできる入門が欲しい?
  - しょうがない作るか(´・ω・｀)
  - イマココ

---

class: center, middle

# 忙しい人のための Julia 入門（環境構築）

---

# 環境構築(その１)

- 基本的には実行バイナリを落としてきてそこにパスを通せば良い.
- [公式ページのダウンロードページ](https://julialang.org/downloads/)
  - `Current stable release` のバージョンを選べば良い.
  - [Platform Specific Instructions for Official Binaries](https://julialang.org/downloads/platform/) に従う.
- [リリースアナウンス](https://discourse.julialang.org/c/announce/25) 
が出たらマイナーバージョンをアップデートすれば良い.
  - 1.8 が出たら 1.7 はメンテされないので捨てる.
  - 1.9 が出たら 1.8 を捨てて 1.9 を使う
  - 欠点: わざわざ差し替えるのがめんどい
- いろんな方法を紹介してるので使いやすいものを選ぶこと

---

# 環境構築(その２)

お手元に Python があれば `jill` インストーラを利用できる

```console
$ pip3 install jill
$ jill install 1.7
JILL - Julia Installer 4 Linux (MacOS, Windows and FreeBSD) -- Light

jill will:
  1) install Julia 1.7 for mac-x86_64 into /Applications
  2) make symlinks in ~/.local/bin
You may need to manually add /Users/terasaki/.local/bin to PATH
Continue installation? [Y/n]
```

`Y` を押してインストールする. `~/.local/bin` に PATH が通っていれば Julia が使える

```console
$ julia --version
julia version 1.7.2
```

---

# 環境構築(その３)

- 主にWindowsユーザー向け
- Windows ユーザーであれば Microsoft Store から `julia` と検索して入手できる.
  パスが通るところにインストールしてくれる. [juliaup](https://github.com/JuliaLang/juliaup) というコマンドもついてくる. このコマンドで適宜最新版を入手できるようになる.

---

# 環境構築(その４)

- Docker公式イメージを使う

```console
$ docker run --rm -it julia:1.7.2
               _
   _       _ _(_)_     |  Documentation: https://docs.julialang.org
  (_)     | (_) (_)    |
   _ _   _| |_  __ _   |  Type "?" for help, "]?" for Pkg help.
  | | | | | | |/ _` |  |
  | | |_| | | | (_| |  |  Version 1.7.2 (2022-02-06)
 _/ |\__'_|_|_|\__'_|  |  Official https://julialang.org/ release
|__/                   |

julia>
```

---

# 環境構築(その５)

クラウド環境でも試せる

- [binder-examples/demo-julia](https://github.com/binder-examples/demo-julia)
  - リンク先にある `launch binder` ボタンを押す
- [Amazon SageMaker Studio Lab](https://studiolab.sagemaker.aws/)

---

# アンインストール

- `jill` で入れた場合は `${HOME}/.local/bin` の `julia` がついているものを全部消す
- Mac だと `/Applications` 以下にある Julia を消す
- Windows ユーザーならば「プログラムのアンインストール」から消す.
- `${HOME}/.julia` を消す.
  - これを消すと Julia を初回インストールした状態に戻すことができる. 何か挙動がおかしい時は一旦消してやり直すというてもありかもしれない.

---

class: center, middle

# REPL で遊ぼう

文法も添えて

---

`julia` というコマンドが使えるようになったはず. REPL が立ち上がる.

```julia
               _
   _       _ _(_)_     |  Documentation: https://docs.julialang.org
  (_)     | (_) (_)    |
   _ _   _| |_  __ _   |  Type "?" for help, "]?" for Pkg help.
  | | | | | | |/ _` |  |
  | | |_| | | | (_| |  |  Version 1.7.2 (2022-02-06)
 _/ |\__'_|_|_|\__'_|  |  Official https://julialang.org/ release
|__/                   |

julia> 1+1
2

julia> println("Hello")
Hello

julia> VERSION
v"1.7.2"

julia> versioninfo()
Julia Version 1.7.2
Commit bf53498635 (2022-02-06 15:21 UTC)
Platform Info:
  OS: Linux (x86_64-pc-linux-gnu)
  CPU: Intel(R) Core(TM) i9-9900K CPU @ 3.60GHz
  WORD_SIZE: 64
  LIBM: libopenlibm
  LLVM: libLLVM-12.0.1 (ORCJIT, skylake)
Environment:
  JULIA_PATH = /usr/local/julia
  JULIA_GPG = 3673DF529D9049477F76B37566E3C7DC03D6E495
  JULIA_VERSION = 1.7.2
```

---

# Tips

`julia>` の部分がプロンプトと呼ばれる. `julia>` の部分も含めてコピペしても REPL 側がいい感じに処理してくれる. 下記のブロックを丸ごとコピーしてみると適切な出力を出すはずだ.

```julia
julia> 1 == 2
true # 実際は false なので実際に動かすと false になる

julia> println("Hello")
World # 実際は Hello が出るはず
```

Python と異なりインデントに関してセンシティブではないのでコードを適当にコピペして自由に実行させることができる.

---

# Unicode 文字列

- Julia の良さは数学的な概念を表現しやすい
  - Unicode 入力支援のおかげで論文や教科書に出てくる $\beta, \hat{y}, x_1, A^a, \pi, \otimes$ をそっくりそのままかける.
  - `julia> β, ŷ, x₁, Aᵃ, π, ⊗`

```julia
julia> β # \beta + <tab>
julia> ŷ # y\hat + <tab>
julia> x₁ # x\_1 + <tab>
julia> Aᵃ # A\^a + <tab>
julia> π # \pi + <tab> これは円周率を表す. `pi` でも良い
julia> ⊗ # \otimes + <tab>
```

---

# Julia is fast(?)

```julia
julia> function mygcd(a, b)
           while b != 0
               tmp = b; b = a % b; a = tmp
           end
           return a
       end
mygcd (generic function with 1 method)
julia> function calcπ(N)
           cnt = 0
           for a ∈ 1:N # ∈ は \in + <tab> `in` でも良い
               for b in 1:N # in の代わりに `=` と書いても良い
                   if mygcd(a, b) == 1
                       cnt += 1
                   end
               end
           end
           prob = cnt / N / N
           return √(6/prob) # √ は \sqrt + <tab>
       end
calcπ (generic function with 1 method)
julia> @time calcπ(10^4)
  4.980897 seconds
3.141534239016629
```

---

```c
#include<stdio.h>
#include<math.h>

int mygcd(int a, int b){
    int tmp;
    while (b != 0) {
        tmp = b; b = a % b; a = tmp;
    }
    return a;
}

double calcpi(int N){
    int cnt = 0;
    for (int a=1; a<=N; a++){
        for(int b=1; b<=N; b++){
            if (mygcd(a, b)==1){cnt++;}
        }
    }
    double prob = (double)cnt / N / N;
    return sqrt(6/prob);
}

int main(){
    double approx = calcpi(10000);
    printf("%.15f\n", approx);
    return 0;
}
```

```console
$ gcc -O2 calcpi.c && time ./a.out
3.141534239016629
./a.out  4.60s user 0.01s system 95% cpu 4.839 total
```
---

```python
import math
import time


def mygcd(a, b):
    while (b != 0):
        tmp = b
        b = a % b
        a = tmp
    return a


def calcpi(N):
    cnt = 0
    for a in range(1, N + 1):
        for b in range(1, N + 1):
            if mygcd(a, b) == 1:
                cnt += 1
    prob = cnt / N / N
    return math.sqrt(6 / prob)


print(calcpi(10000))
```

```console
$ time python calcpi.py
3.141534239016629
python calcpi.py  47.90s user 0.21s system 99% cpu 48.265 total
```

---

# Julia is fast (?!)

```julia
julia> function calcπ(N)
           cnt = 0
           for a ∈ 1:N # ∈ は \in + <tab> `in` でも良い
               for b in 1:N # in の代わりに `=` と書いても良い
                   if gcd(a, b) == 1 # Julia 標準の gcd は実は速い
                       cnt += 1
                   end
               end
           end
           prob = cnt / N / N
           return √(6/prob) # √ は \sqrt + <tab>
       end
calcπ (generic function with 1 method)

julia> @time calcπ(10^4)
  2.277574 seconds
3.141534239016629
```

Julia の gcd は [binary GCD (aka Stein's) algorithm](https://github.com/JuliaLang/julia/blob/bf534986350a991e4a1b29126de0342ffd76205e/base/intfuncs.jl#L50-L71) を採用している.

[mygcd はここを参考にした](https://github.com/JuliaLang/julia/blob/bf534986350a991e4a1b29126de0342ffd76205e/base/intfuncs.jl#L41-L48)

---

# Julia はもう少しスマートにかける

```julia
julia> function calcπ(N)
           cnt = 0
           for a = 1:N, b = 1:N
               cnt += ifelse(gcd(a, b) == 1, 1, 0)
           end
           prob = cnt / N / N
           # 実は return は不要. 最後に評価した式の値を返す.
           √(6 / prob) # √ は \sqrt + <tab>
       end
calcπ (generic function with 1 method)

julia> @time calcπ(10^4)

  2.338910 seconds
3.141534239016629

julia> @time calcπ(5*10^4)
 67.926152 seconds
3.141560849524047
```

---

# Multi-Threading

```julia
# calcpi_thread.jl
using Base.Threads

function calcπ(N)
    cnt = Atomic{Int}(0)
    Threads.@threads for a = 1:N
        for b = 1:N
            Threads.atomic_add!(cnt, ifelse(gcd(a, b) == 1, 1, 0))
        end
    end
    prob = cnt.value / N / N
    # 実は return は不要. 最後に評価した式の値を返す.
    √(6 / prob) # √ は \sqrt + <tab>
end

@time @show calcπ(10^4)
@time @show calcπ(5*10^4)
```

```console
$ julia -t auto calcpi_thread.jl
calcπ(10 ^ 4) = 3.141534239016629
  1.453167 seconds (66.57 k allocations: 3.809 MiB, 2.61% compilation time)
calcπ(5 * 10 ^ 4) = 3.141560849524047
 44.661406 seconds (101 allocations: 8.141 KiB)
```

---

# Multi-Processing

```julia
# calcpi_distributed.jl
using Distributed

function calcπ(N)
    cnt = @distributed (+) for a = 1:N
        s = 0
        for b = 1:N
            s += ifelse(gcd(a, b) == 1, 1, 0)
        end
        s
    end
    prob = cnt / N / N
    √(6 / prob)
end

@time calcπ(10^4)
@time calcπ(5*10^4)
```

```console
julia -p auto calcpi_distributed.jl
  2.389998 seconds (1.17 M allocations: 63.687 MiB, 0.27% gc time, 20.13% compilation time)
  6.294771 seconds (2.39 k allocations: 101.531 KiB)
```

---

# 補足

```julia
julia> print("Hello")
Hello
julia> print("Hello"); print("World")
HelloWorld
julia> println("Hello"); println("World")
Hello
World

julia> msg = "HelloWorld"
"HelloWorld"

julia> @show msg # マクロ. Python の `print(f"{msg=}")` 相当
msg = "HelloWorld"
"HelloWorld"

julia> @macroexpand @show msg # コード生成している様子がわかる.
quote
    Base.println("msg = ", Base.repr(begin
                #= show.jl:1047 =#
                local var"#2#value" = msg
            end))
    var"#2#value"
end

```

---

# Install Julia Package

```julia
julia> using Pkg; Pkg.add("Example") # セミコロンで複数の命令を連続して実行できる.

    Updating registry at `~/.julia/registries/General.toml`
   Resolving package versions...
    Updating `~/.julia/environments/v1.7/Project.toml`
  [7876af07] + Example v0.5.3
    Updating `~/.julia/environments/v1.7/Manifest.toml`
  [7876af07] + Example v0.5.3
Precompiling project...
  1 dependency successfully precompiled in 2 seconds (482 already precompiled, 2 skipped during auto due to previous errors)

julia> using Example # `hello` という関数を export する

julia> hello("world")
"Hello, world"
```

---

# Install Julia Package (Project版)

(お仕事などの) プロジェクト毎で使用するパッケージのバージョンが異なる場合は作業場所でアクティベートをする.

例:

`~/tmp/proj1` がプロジェクト１の作業場所とする. ここでは `v0.4` を使いたい

```julia
julia> using Pkg; Pkg.activate("."); Pkg.add(PackageSpec(name="Example", version=v"0.4"))
  Activating new project at `~/tmp/proj1`
    Updating registry at `~/.julia/registries/General.toml`
   Resolving package versions...
   Installed Example ─ v0.4.0
    Updating `~/tmp/proj1/Project.toml`
  [7876af07] + Example v0.4.0
    Updating `~/tmp/proj1/Manifest.toml`
  [7876af07] + Example v0.4.0
Precompiling project...
  1 dependency successfully precompiled in 1 seconds
```


続く

---

# Install Julia Package (Project版, 続き)

例:

`~/tmp/proj2` がプロジェクト2の作業場所とする. ここでは `v0.5.3` を使いたい

```julia
julia> using Pkg; Pkg.activate("."); Pkg.add(PackageSpec(name="Example", version=v"0.5.3"))
  Activating new project at `~/tmp/proj2`
    Updating registry at `~/.julia/registries/General.toml`
   Resolving package versions...
    Updating `~/tmp/proj2/Project.toml`
  [7876af07] + Example v0.5.3
    Updating `~/tmp/proj2/Manifest.toml`
  [7876af07] + Example v0.5.3
```

プロジェクト毎に使いパッケージの管理をすることができる. 記録は `Project.toml` とさらに詳細な情報も含めた `Manifest.toml` にて行われる. 後者はパッケージのインストールなどの操作によって自動生成・変更される. 他の言語の `lock` ファイルのようなものだと思えば良い. `Manifest.toml` を共有することで依存関係を再現できる（はず).

---


# Install Julia Package (Pkg REPL による方法)

```julia
julia> # press ] Pkg REPL で導入しても良い

(@v1.7) pkg> add Example
   Resolving package versions...
    Updating `~/.julia/environments/v1.7/Project.toml`
  [7876af07] + Example v0.5.3
    Updating `~/.julia/environments/v1.7/Manifest.toml`
  [7876af07] + Example v0.5.3
```

`~/.julia` 以下にソースや依存関係が落ちてくる. この場所は Julia からだと `Base.DEPOT_PATH[1]` という式で参照できる.

---

# Remove Package

```julia
(@v1.7) pkg> rm Example
    Updating `~/.julia/environments/v1.7/Project.toml`
  [7876af07] - Example v0.5.3
    Updating `~/.julia/environments/v1.7/Manifest.toml`
  [7876af07] - Example v0.5.3
```

1.7 から明示的に `Pkg.add` しなくても `using Example` を実行した際にいい感じに聞いてくれるようになった.

```julia
julia> using Example
 │ Package Example not found, but a package named Example is available from a registry.
 │ Install package?
 │   (@v1.7) pkg> add Example
 └ (y/n) [y]: y
    Updating registry at `~/.julia/registries/General.toml`
   Resolving package versions...
    Updating `~/.julia/environments/v1.7/Project.toml`
  [7876af07] + Example v0.5.3
    Updating `~/.julia/environments/v1.7/Manifest.toml`
  [7876af07] + Example v0.5.3

julia> hello("world")
"Hello, world"
```

---

# REPL で色々(help mode)

```julia
julia> # press ?
help?>
search:  ] [ = $ ; ( @ { " ) ? . } ⊽ ⊼ ⊻ ⊋ ⊊ ⊉ ⊈ ⊇ ⊆ ≥ ≤ ≢ ≡ ≠ ≉ ≈ ∪ ∩ ∛ √ ∘ ∌ ∋ ∉ ∈ ℯ π ÷

  Welcome to Julia 1.7.2. The full manual is available at

  https://docs.julialang.org

  as well as many great tutorials and learning resources:

  https://julialang.org/learning/

  For help on a specific function or macro, type ? followed by its name, e.g. ?cos, or
  ?@time, and press enter. Type ; to enter shell mode, ] to enter package mode.
```

---

# REPL で色々(shell mode)

Julia のREPLを終了しなくてもちょろっとしたことをシェルでしたい場合に便利

```julia
julia> # press ;
shell> ls
build           calcpi.py       make.jl
calcpi.c        calcpi_distributed.jl   src
calcpi.jl       calcpi_thread.jl
```

---

# REPL で遊ぶ

```julia
julia> using TerminalClock

julia> clock()
+-------+ +-------+           +-------+ +-------+                   + +-------+
        |         |                   | |       |                   |         |
        |         |     ⊗             | |       |     ⊗             |         |
        |         |                   | |       |                   |         |
+-------+ +-------+           +-------+ +-------+                   + +-------+
|                 |           |                 |                   | |
|                 |     ⊗     |                 |     ⊗             | |
|                 |           |                 |                   | |
+-------+ +-------+           +-------+ +-------+                   + +-------+

```

補足

```julia
(@v1.7) pkg> st TerminalClock
      Status `~/.julia/environments/v1.7/Project.toml`
  [65687e93] TerminalClock v0.4.0
```
---

# REPL で遊ぶ

あらかじめ仕込んだスクリプトを自動実行してくれる.

- みんな大好き Iris データセットを PCA によって次元削減した結果を描画する

```julia
julia> using Replay
julia> include(joinpath(pkgdir(Replay), "examples", "iris", "app.jl"))
```

- REPL の上で画像表示

```julia
julia> using Replay
julia> include(joinpath(pkgdir(Replay), "examples", "imageinterminal", "app.jl"))
```

- 端末が Sixel Graphics 対応ならこっちが綺麗

```julia
julia> using Replay
julia> include(joinpath(pkgdir(Replay), "examples", "sixel", "app.jl"))
```

---

class: center, middle

# リッチな環境を使いたい

---

# もうちょっとリッチな環境を使いたい

- 真っ黒な画面で触るのは飽きた. 可視化したい. (´・ω・｀)
- そっかー(´・ω・｀)

## IJulia.jl

- Jupyter Notebook の Julia カーネルを利用できる.

```julia
julia> using IJulia; notebook()
```

`localhost:8888` に行くと Pythonista にとって馴染みのある画面が見える.

[Demo](https://gist.github.com/terasakisatoshi/d8743200909d600f8a6a8053b798839e)

---

# Pluto.jl

Julia のための Reactive Notebook.

```julia
julia> using Pluto; Pluto.run()
```

`localhost:1234` に行く.

1つのセルを更新すると依存関係を解析し他のセルで定義した変数の値も更新する.

---

class: center, middle

# Python vs Julia

--

不毛な論争

--

仲良くしよう

---

# Python は Julia のライブラリ

```julia
julia> using PyCall
julia> plt = pyimport_conda("matplotlib.pyplot", "matplotlib")
julia> x = -pi:0.01:pi
julia> y = sin.(x)
julia> plt.plot(x, y)
julia> plt.show()
```

↑ のようにする必要はなく PyPlot.jl を使えば良い

```julia
julia> using PyPlot
julia> x = -pi:0.01:pi
julia> y = sin.(x)
julia> plt.plot(x, y)
julia> plt.show()
```

PyPlot.jl SciPy.jl SymPy.jl Seaborn.jl Pandas.jl ScikitLearn.jl Kyulacs.jl PyPlotly.jl etc...

---

# Julia は Python のライブラリ

あらかじめ Julia と PyCall.jl をインストールしておく必要がある

```console
$ pip3 install julia
```

```python
>>> from julia import Main; Main.eval("using TerminalClock; clock()")
+-------+ +-------+                   + +-------+           +-------+ +       +
|       | |       |                   |         |           |       | |       |
|       | |       |     ⊗             |         |     ⊗     |       | |       |
|       | |       |                   |         |           |       | |       |
+       + +       +                   + +-------+           +       + +-------+
|       | |       |                   | |                   |       |         |
|       | |       |     ⊗             | |             ⊗     |       |         |
|       | |       |                   | |                   |       |         |
+-------+ +-------+                   + +-------+           +-------+         +
```

---

class: center, middle

# Web Application

---

# Web Application

- [Dash.jl](https://github.com/plotly/Dash.jl)
  - Plotly などを使える
  - [Examples](https://github.com/plotly/Dash.jl/issues/50)

- [Genie.jl](https://github.com/GenieFramework/Genie.jl)
  - Ruby on Rails や Django などと同様に MVC like なWeb フレームワーク
  - Example [ElasticCollision.jl](https://github.com/AtelierArith/ElasticCollision.jl)

---

class: center, middle

# お前も Julia をやらないか (画像略)

---

# 自作パッケージを作る

```julia
julia> using Pkg

julia> Pkg.generate("MyPkg")
  Generating  project MyPkg:
    MyPkg/Project.toml
    MyPkg/src/MyPkg.jl
Dict{String, Base.UUID} with 1 entry:
  "MyPkg" => UUID("xxxxxxxxxxxxx") # <--- 適当な UUID が振られる.
julia> exit() # 一旦終了
```

---

# 自作パッケージを作る

雛形が作られる

```console
$ cat MyPkg/src/MyPkg.jl
module MyPkg

greet() = print("Hello World!")

end # module
```

```julia
$ cd MyPkg
$ julia --project=@. # これで Pkg.activate(".") の呪文を省略できる

julia> using MyPkg
julia> MyPkg.greet()
Hello World! # できた
```

あとはいっぱい書いていけば良い.

---

# MyTemplate.jl

このスライドの作成者が管理しているオレオレ雛形生成器

[PkgTemplates.jl](https://github.com/invenia/PkgTemplates.jl) をさらに拡張した便利機能満載

```console
$ git clone https://github.com/terasakisatoshi/MyTemplate.jl.git
$ cd MyTemplate.jl
$ julia --project=@. generate.jl YourPkg --with-jupyter
$ cd YourPkg.jl
$ make # Docker イメージのビルド
$ make test # パッケージのテストを走らせる
$ docker-compose up lab # Jupyter Lab 環境を立ち上げられる
$ make clean # お掃除
```

---

# sysimage_creator

Julia は JIT コンパイルのコストが重めなのでよく使う関数のコンパイル済みの結果を sysimage に追加しておく.

```console
$ git clone https://github.com/terasakisatoshi/sysimage_creator.git
$ pip install jupyter jupytext nbconvert ipykernel
$ cd sysimage_creator && make && jupyter notebook
$ make test でどれだけ速くなるかを確認できる
```

---

class: center, middle

# お前も Julia をやらないか（画像略）


---

# よく言われること

- なぜか周りで使っている人が少ない（なぜ？）
  - 乱立しているパッケージマネージャー，フォーマッタ，ライブラリのデプロイ，型アノテーションに苦しみながら Python を使っている人を見ると気の毒に思えて仕方がない.
- 破壊的な変更やエラーがめっちゃ出る (既に過去の話)
  - v0.6 の時代は確かにそうだった. ライブラリのインストールやサンプルコードすらままならない時はあった.
  - 単に入門するのであれば LTS の v1.6 を使えば特に困らない. v1.x から言語仕様が固まったのでライブラリを作る側が頑張って安定させている.
  - ソースコードは公開されているので直してプルリクエストを送れば良い. 実現すればあなたはその分野でヒーローになれる.
- プレコンパイル/JITコンパイル のオーバヘッドが重い(改良の余地はある)
  - 1.6 までのアップデートでだいぶマシになった.
  - カスタム sysimage を作る
  - この機会に良いマシンを買うと経済を回すことができる.

---

# よく言われること

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

# よく言われること

- 使っている仕事が見つからない
  - 既にあるソフトウェアを書き直すのは大変なので
  - 新規開発案件にアンテナを伸ばしてチャンスを伺う
  - GitHubで自分で例をいっぱい作れば良い
  - パッケージとして公開する方法は思ったよりも簡単
- 日本語の文献が少ない
  - 英語を読めばいいじゃない(一方で，日本語の解説は増えてきている)
  - 日本語で会話したい時は Twitter/Slack/Discord/Connpass で勉強会や雑談会がある
  - 公式ドキュメントに基づいた解説があると喜ぶ人多そう
  - 単に使ってみたで終わるものではなく, その記事を読みそこから得た知識から応用できる余地を見出せると良い記事が書ける.

---

# 結論

みんなで使えば怖くない