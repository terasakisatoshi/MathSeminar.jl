class: center, middle

# Pluto.jl 入門

ようやく便利になってきた.

2022/12/17

---

# Pluto.jl

Julia のためのノートブック

- ホームページ: https://plutojl.org/
- コード(GitHub): https://github.com/fonsp/Pluto.jl

特徴:

- 環境構築が容易
- IJulia.jl と異なりセル間の依存関係を検知し更新する.
- 簡易な UI の構築
- 共有もできる
- 講義資料としても活用できる

---

# 環境構築が容易

- [IJulia.jl](https://github.com/JuliaLang/IJulia.jl) と異なり Python に依存しない.
- Julia の REPL から `julia> using Pkg; Pkg.add("Pluto")` で入手できる.
  - 巷でよくある(?) Python と Julia の連携時のインストールトラブルの壁を解消できる.
- Julia の Docker イメージをベースに構築することもできる.
  - これだけで起動準備が整う.

```console
$ docker run --rm -it \
    -v $PWD:/work \
    -w /work \
    -p 1234:1234 \
    julia:1.8.3 \
    julia -e 'using Pkg; Pkg.add("Pluto"); using Pluto; Pluto.run(host="0.0.0.0")'
```

---

# Jupyter Notebook でもいいけれど

- Jupyter Notebook は確かに便利.
  - Julia, Python, R はもちろんのこと C++ や Rust とかもカーネルを入れれば多くの言語に対応できる.
- 人間が任意の順序でセルを実行できる(してしまう). 結果として:
  - 再現性の確保が難しい. 
    - 一番目のセルに `In [140]` が, 二番目に `In [20]` のようにぐちゃぐちゃしたコードが残る.
    - 依存関係にあるセルを自動更新してくれない.
    - カーネルを再起動前後で特定のコードが動く・動かない問題が出る.
    - Restart and Run All して動作が確認してからコミットしましょう...
  - 人類, 無遠慮に `ipynb` を直 push しがち
    - リポジトリを肥大化させる.
    - 意図しない情報を共有してしまう.
    - jupytext とか gist 使おうね

---

# 一方で Pluto.jl は

- Reactive な特徴を持っている:
  - セル間の依存を解決してくれる.
  - `name` を `"ごま"` から `"わもん"` に変えたり `name` の型アノテーションをつけたり.
  - うっかり構造体の再定義をする必要が出て, カーネルの再起動みたいなことが起きない.

<div>
    <img width="400" alt="image" src="https://user-images.githubusercontent.com/16760547/208232529-acfa85b3-1493-4d81-b762-73fce21774d5.png"> <img width="300" alt="image" src="https://user-images.githubusercontent.com/16760547/208232604-f739f2f0-5efa-42a1-94fc-d3454602e77b.png">
</div>

---

# 簡易 UI 作成が可能

- PlutoUI.jl で基本的なコンポーネントはサポートされている.
- サンタさん. 私にフロントエンド力をください.


```julia
begin
    種類 = ["ごま", "わもん", "くらかげ"]
    鳴き声 = ["きゅ", "キュイ", "んごぉ！", "ウォ, ウォwwww"]
    ui1 = @bind name Select(種類)
    ui2 = @bind nakigoe Select(鳴き声)
    PlutoUI.ExperimentalLayout.hbox([ui1, ui2])
end
```

```julia
begin
    a = Azarashi(name, nakigoe)
    a
end
```

---

# Result

<img width="800" alt="image" src="https://user-images.githubusercontent.com/16760547/208233755-0697b28e-e33e-4b12-9f95-6b5c08785790.png">

---

# 使用実績

## 講義資料として

- [Introduction to Computational Thinking](https://computationalthinking.mit.edu/Fall20/) で使われている.
- [PlutoSliderServer.jl](https://github.com/Pluto/PlutoSliderServer.jl) で資料が公開されている.

- 自分も[真似してみた](https://github.com/terasakisatoshi/MyPlutoflow.jl)けれど十分メンテできてない.

## JuliaHub でのノートブックインスタンス

VSCode ライクな UI または Pluto ベースのノートブックを利用することができる.

https://juliahub.com/

(いろんな意味でもうちょっと頑張ってほしい)

---

## Jupyter Lab 側から

https://github.com/IllumiDesk/jupyter-pluto-proxy

を使うと Jupyter のカーネルとして認識させられる.

https://github.com/terasakisatoshi/MyTemplate.jl 

で環境構築をできるようになってる（はず）

## VSCode から

アルファ版だけれど一応ある

https://marketplace.visualstudio.com/items?itemName=JuliaComputing.pluto-vscode

---

# 嬉しいこと

- Live Docs が割と便利.
    - クリックしたらドキュメントが見られる.
- テキストファイルベースで管理できる.
- ダークモードで動かせて目に優しい.
- `@assert` マクロを別のセルに仕込んで書きながら動作確認が可能になった
- `struct ... end` の変更がカジュアルにできるようになった
  - 実験段階における [TTFX](https://discourse.julialang.org/t/taking-ttfx-seriously-can-we-make-common-packages-faster-to-load-and-use/74949?page=2) を緩和することができる.
- `Cmd+D` でマルチカーソルが正常に動作した. `v0.19.16` から.
  - これで Jupyter Notebook をほとんど使わなくなった.
- HTML 化させたものを gist においておいて共有できるリンクを作成できる
  - [2022年ばんの Qiita アドカレで書いた](https://qiita.com/SatoshiTerasaki/items/43e7e81c256cf5627181)

---

# 難儀なこと

- ノートブックを起動したら全部動く...
  - [Pluto.jl/issues/259](https://github.com/fonsp/Pluto.jl/issues/259)
  - [開発者の Notion でのメモ](https://www.notion.so/Notebook-security-d8162867a8c04b1793912d78cefee02a)
  - 特定のセルの Disable 機能があるのでこれで凌げるか？

---

# 難儀なこと

- 変数の再定義
  - 同じ名前を使った変数の使い回しができない.（これはリアクティブな仕組みを考えるとしょうがない）
  - `let ... end` ブロックを使って回避できる. 知らないと人生が詰む.

```julia
let
    x = "something"
    function f(x)
        # do something
    end
    # let ないの変数を指定するために各所にドルマークでの補間が必要
    @benchmark $f($x)
end
```

- Julia + Web 開発できるリソースがそもそも足りてなさそう.

---
class: center, middle

# JuliaCon における Pluto.jl のトーク集

自分向け資料

---

## JuliaCon 2020 | Interactive notebooks ~ Pluto.jl | Fons van der Plas

<iframe width="560" height="315" src="https://www.youtube.com/embed/IAF8DjrQSSk" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

---

# Pluto.jl — one year later | Fons van der Plas | JuliaCon2021

<iframe width="560" height="315" src="https://www.youtube.com/embed/HiI4jgDyDhY" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

---

# Visualization Dashboards with Pluto! | Guilherme Gomes Haetinger | JuliaCon 2022

<iframe width="560" height="315" src="https://www.youtube.com/embed/dP9UuEL00iM" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

---

# Julia Programming (Pluto.jl) with a Data Scientist: The Iris Dataset, DataFrames, and Plotting Data

<iframe width="560" height="315" src="https://www.youtube.com/embed/a_H_W2RyWTc" title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

https://www.youtube.com/watch?v=a_H_W2RyWTc
