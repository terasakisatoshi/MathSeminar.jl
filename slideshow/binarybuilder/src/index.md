class: center, middle

# BinaryBuilder.jl 入門

ごまふあざらし

---

class: center, middle

# の前に

-- 

## ソフトウェア開発のモチベーション

--

## 注意

一部幼児退化しているところあり

---

# 開発のモチベーション(理想)

#### `XXX` 関連のたのちぃ(楽しい) こと

- 技術 `XXX` を使いたい, 技術 `XXX` でパッケージ開発をしたい (e.g. `XXX = JuliaLang`)
- `オレノツクッタサイツヨライブラリ for XXX` ヲツクッタヨ. ヨカッタラツカッテクレ

#### 技術 `XXX` でうれちぃ(嬉しい) こと

- 他の進行中のプロジェクトと連携 (Go/Rust/...)
- 既存の資源 (C/C++/Fortran/Python/JavaScript/...) をうまく活用
- 依存関係をスムーズにインストール

#### 結果

- ククク, いでよ我の最強のソフトウェア!!! (ぽちっとな！)

---


# 開発のモチベーション(現実 part 1)

#### ちゅらい(辛い)

- デブロイ先でうまくいかない
  - ModuleNotFoundError: No module named ...
  - No such a file or directory ...
  - Library not found for ...
  - Segmentation fault ...

- 追加で下記のようにして対策してください... (><;). 
  - pip install ...
  - apt/apt-get/apk...　
  - brew/port...        
  - choco/winget...     
  
- ユーザA「動いたよ」, ユーザB「動かねぇ」

---

# 開発のモチベーション(現実 part 2)

#### ちゅらい(辛い)

- ここから手動でダウンロードしてと指示
  - 指示ミス，操作ミスで沼にハマる
- そうだ全部コミットしよう！
  - `git add heavy_file && git commit -m "..." && git push ... # fail`
- しょうがない. そちらの環境でソースからビルドして
  - え？手元にコンパイラーがない？ (e.g. Windows)
- Linux/Mac で動作確認したよ！ Windows は... コントリビューションイズウェルカム！
 
#### 結果

- バカな, 私の作ったソフトウェアは完璧だったはず(ウワァァ)

---

class: center, middle


# こうして, 現実世界はソフトウェア開発者を次々絶望の底に叩きつけた.

-- 

## もちろん人類は愚かではない. 彼らは様々な技術で現実世界と向き合うのである

---

class: center, middle

# ここから真面目な話

-- 

## Julia コミュニティにおける工夫

---

class: center, middle

# Julia コミュニティにおける工夫

--

## Artifacts

#### 生成物/依存関係の管理

--

## JLL package

#### ライブラリ・実行形式のラッパー

--

## BinaryBuilder

#### 依存関係, ライブラリ, ラッパーの生成

---

class: center, middle

# Artifacts 入門

---

# Artifacts 入門 (概要)

- パッケージマネージャ Pkg が機能を持っている.
- ファイルは `Artifacts.toml` で行う.生成物(e.g. データ，実行形式)の実体, 格納場所をハッシュで紐づけ.

#### Example

https://julialang.github.io/Pkg.jl/dev/artifacts/#Artifacts から引用

```toml
$ cat Artifacts.toml
# a simple Artifacts.toml file
[socrates]
git-tree-sha1 = "43563e7631a7eafae1f9f8d9d332e3de44ad7239"

    [[socrates.download]]
    url = "https://github.com/staticfloat/small_bin/raw/master/socrates.tar.gz"
    sha256 = "e65d2f13f2085f2c279830e863292312a72930fee5ba3c792b14c33ce5c5cc58"
$ julia -q
julia> rootpath = artifact"socrates"
Downloading artifact: socrates
######################################################################## 
julia> open(joinpath(rootpath, "bin", "socrates")) do file; println(read(file, String)); end
#!/bin/bash

echo -n "ἔοικα γοῦν τούτου γε σμικρῷ τινι αὐτῷ τούτῳ σοφώτερος εἶναι, ὅτι ἃ μὴ οἶδα οὐδὲ οἴομαι εἰδέναι."
```

---

# Artifacts 入門 (toml の作成)

`Artifacts.toml` 自信を作る方法の情報が断片的だったのでまとめておく.

- 手動で編集をするものではない 
- [r3tex/ObjectDetector.jl/dev/artifacts/generate_artifacts.jl](https://github.com/r3tex/ObjectDetector.jl/blob/master/dev/artifacts/generate_artifacts.jl#L50) にあるように `bind_artifact!` 関数で作る.
- [ArtifactUtils.jl](https://github.com/simeonschaub/ArtifactUtils.jl) で作る(これが一番簡単).

```julia
julia> using ArtifactUtils, Pkg.Artifacts # Pkg.Artifacts provides the artifact string macro
julia> add_artifact!(
           "Artifacts.toml", "JuliaMono",
           "https://github.com/cormullion/juliamono/releases/download/v0.021/JuliaMono.tar.gz",
           force=true,
       )
SHA1("888cda53d12753313f13b607a2655448bfc11be5")
```

- JLLで運用する場合は BinaryBuilder.jl がお世話してくれるので概念的を知っていれば良さそう.

References:

- [A couple of questions about Artifacts](https://discourse.julialang.org/t/a-couple-of-questions-about-artifacts/33367)
- [Providing Artifacts basics](https://discourse.julialang.org/t/providing-artifacts-basics/35459/5)

---

# Examples

- [TestImages.jl](https://github.com/JuliaImages/TestImages.jl)
  - GitHub Release ページの [v1.3.0-artifacts](https://github.com/JuliaImages/TestImages.jl/releases/tag/v1.3.0-artifacts) からダウンロードするようになっている.
- [PackageCompiler.jl](https://github.com/JuliaLang/PackageCompiler.jl)

```toml
[[x86_64-w64-mingw32]]
git-tree-sha1 = "fdff308295487f361ef6e8dc2d27f5abe8a6eee9"
os = "windows"
arch = "x86_64"
lazy = true

    [[x86_64-w64-mingw32.download]]
    sha256 = "fe3f401bc936fbe6af940b26c5e0f266f762a3416f979c706e599b24082dc5c7"
    url = "https://github.com/JuliaLang/PackageCompiler.jl/releases/download/v1.0.0/x86_64-8.1.0-release-posix-seh-rt_v6-rev0.tar.gz"
```

  - Windows 環境でコンパイラーがない場合に動的 (lazy) にダウンロードされる.
    - See [`get_compiler`](https://github.com/JuliaLang/PackageCompiler.jl/blob/69f556a6d6d1abb3f9f9d1bb46edfe4df5c66d25/src/PackageCompiler.jl#L97-L111) function

---

class: center, middle

# JLL 入門

---

# JLL 入門 (導入)

- パッケージ導入時に `_jll` というパッケージがインストールされているのを見かける.

```julia
pkg> add OrenokangaetaSaitsuyoJuliaPackage
...
...
...
   Updating git-repo `https://github.com/JuliaRegistries/General.git`
  Resolving package versions...
  Installed Xorg_xcb_util_jll ──────────── v0.4.0+0
  Installed Xorg_xcb_util_keysyms_jll ──── v0.4.0+0
  Installed Qt_jll ─────────────────────── v5.15.0+3
  Installed libcxxwrap_julia_jll ───────── v0.8.0+0
  Installed Xorg_xcb_util_wm_jll ───────── v0.4.1+0
  Installed Xorg_xcb_util_renderutil_jll ─ v0.3.9+0
  Installed CxxWrap ────────────────────── v0.11.0
  Installed ImageInTerminal ────────────── v0.4.5
  Installed Xorg_xcb_util_image_jll ────── v0.4.0+0
...
...
...
```

これってなんだろう？

---

# JLL (Julia library packages)

## A pun on "Dynamic-Link Library"

- Julia界隈における `DLL(=Dynamic-Link Library)` の役割を果たす.
- Julia のパッケージは C/C++/Fortran で作られた既存のライブラリ/実行形式をラップしている物がある.
  - JLL は主にそのようなラップする機能を果たしているのが多い.
  - あるパッケージの補助の役割を果たしているのでエンドユーザは意識する必要はない.
  - 通常の Julia パッケージとして扱える(See next page).
  - Julia パッケージに対する(Julia以外の)依存関係を JLL で閉じた世界を作りたい.
  
## References

- [Pkg + BinaryBuilder -- The Next Generation](https://julialang.org/blog/2019/11/artifacts/#julia_library_jll_packages)

---

# Example of JLL: `HelloWorldFortran_jll`

### Install

```julia
(@v1.5) pkg> add HelloWorldFortran_jll
  Resolving package versions...
  Installed HelloWorldFortran_jll ─ v1.1.0+0
Downloading artifact: HelloWorldFortran
##################################################
Updating `~/.julia/environments/v1.5/Project.toml`
  [b7e79332] + HelloWorldFortran_jll v1.1.0+0
Updating `~/.julia/environments/v1.5/Manifest.toml`
  [b7e79332] + HelloWorldFortran_jll v1.1.0+0
```

### Let's run

```julia
julia> using HelloWorldFortran_jll: hello_world
julia> HelloWorldFortran_jll.hello_world(x->run(`$x`)) # ,or use do-syntax as follow:
julia> hello_world() do exe
           run(`$exe`)
       end
Hello, World!
```

--- 

# Example of JLL: `libcxxwrap_julia_jll`

- [CxxWrap.jl](https://github.com/JuliaInterop/CxxWrap.jl) が依存する JLL パッケージ

```console
# open your terminal
$ git clone https://github.com/JuliaInterop/CxxWrap.jl.git
$ cd CxxWrap.jl
$ cat Project.toml
name = "CxxWrap"
uuid = "1f15a43c-97ca-5a2a-ae31-89f07a497df4"
authors = ["Bart Janssens <bart@bartjanssens.org>"]
version = "0.11.0"

[deps]
Libdl = "8f399da3-3557-5675-b5ff-fb832c97cbdb"
MacroTools = "1914dd2f-81c6-5fcd-8719-6d5c9610ff09"
libcxxwrap_julia_jll = "3eaa8342-bff7-56a5-9981-c04077f7cee7"
```

```console
$ head -n 15 src/CxxWrap.jl
module CxxWrap
(中略: omitted)
using libcxxwrap_julia_jll # for libcxxwrap_julia and libcxxwrap_julia_stl
```

---

# 疑問


## リポジトリはどこ？

- [https://github.com/JuliaBinaryWrappers](JuliaBinaryWrappers) という Organization で見つけることができる.
- これらは自動でリポジトリが作られている (<--- 下記参照)

## どうやって作ってるの?

- BinaryBuilder.jl を使って JLL を作成するスクリプト `build_tarball.jl` を作成する.
  - あとで詳しく述べる.
- `build_tarball.jl` を集めている [Yggdrasil](https://github.com/JuliaPackaging/Yggdrasil) に PR(Pull Request) を送る.
- PR が通ると `XXX_jll` パッケージが JuliaBinaryWrappers 以下にリポジトリが作られる.

---

class: center, middle

# BinaryBuilder.jl

やっと話せる.

