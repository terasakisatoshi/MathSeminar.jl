class: center, middle

# Julia プロジェクト [MyWorkflow.jl](https://github.com/terasakisatoshi/MyWorkflow.jl) の紹介

ごまふあざらし

![](assets/qrcode.png)

---

# 自己紹介

- 細々と仕事で Python/Julia を用いたプログラムを書いています.

# ここではなすこと

- 自作 Julia プロジェクトの [MyWorkflow.jl](https://github.com/terasakisatoshi/MyWorkflow.jl) の紹介

---

# Julia の嬉しいところ

- 動的言語であることによる簡易さ
- ギリシャ文字, 添字, 修飾文字が変数に使え数学的概念の記述が楽しくできる.
```julia
julia> using SpecialFunctions
julia> ζ(s) = zeta(s)
julia> ζ(2)
1.6449340668482273
julia> sum(n->1/n^2, 1:100000)
1.644924066898228
julia> π^2/6
1.6449340668482264
```
- サイエンスがバックグラウンドにある人が多いコミュニティ
- REPL/Jupyter/Pluto などリッチな開発環境
- 他の言語との連携が充実
- Web 開発もできる
  - このスライド，Web ページの作成も Julia が一枚噛んでいます.

---

# Motivation (Part 1)

- 下記のようなわがままな人にでも使ってもらうようにしたい.
  - 開発環境構築めんどくさい
  - すぐ使いたい
  - 関数のグラフを書きたい, データの可視化をしたい
  - とりあえず手元で触れるもの

---

# Motivation (Part 2-1)

- プログラミング言語の学習における学習者の負荷を軽減するため
  - 環境構築
  - Jupyter Notebook の管理
  - パッケージ構成
  - テスト/CI/CD をどうするか？
  - 公開/配布をどうするか？

---

# Motivation (Part 2-2)

- プログラミング言語の学習における学習者の負荷を軽減するため
  - 環境構築
    - [Docker](https://www.docker.com/)
  - Jupyter Notebook の管理
    - [Jupytext](https://jupytext.readthedocs.io/en/latest/)
  - パッケージ構成
    - [PkgTemplates.jl](https://github.com/invenia/PkgTemplates.jl)
  - テスト/CI/CD をどうするか？
    - [GitHub Actions](https://docs.github.com/en/actions) の活用
  - 公開/配布をどうするか？
    - [GitHub](https://github.com/), [Binder](https://mybinder.org/)

---

# Have a try!

- https://mybinder.org/ を利用して Julia の環境が手元になくても Web で動かすことができる.
  - MyWorkflow.jl master (nightly) [![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/terasakisatoshi/MyWorkflow.jl/master) Julia v1.6.1
  - MyWorkflow.jl v0.24.0 (stable) [![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/terasakisatoshi/MyWorkflow.jl/v0.24.0) Julia v1.6.1

---

# Result (Part 1)

<img width="800" alt="Screen Shot 2021-05-23 at 17 53 37" src="https://user-images.githubusercontent.com/16760547/119254180-e3e5d400-bbef-11eb-82f2-4cf07c1b91f4.png">

---

# Result (Part 2)

<img width="600" alt="Screen Shot 2021-05-23 at 17 55 13" src="https://user-images.githubusercontent.com/16760547/119254221-1263af00-bbf0-11eb-8a06-dc8820776cd4.png">

---

# Example 1

- PCA を MNIST に適用

<img width="654" alt="Screen Shot 2021-05-28 at 14 16 17" src="https://user-images.githubusercontent.com/16760547/119933658-7951e100-bfbf-11eb-8881-1206eb734046.png">

---

# Example 2

- Interact.jl の例

<img width="650" alt="Screen Shot 2021-05-28 at 14 18 45" src="https://user-images.githubusercontent.com/16760547/119933767-aa321600-bfbf-11eb-8c3c-8d1dcd468b62.png">

---

# Example 3

- Images.jl の例

![image](https://user-images.githubusercontent.com/16760547/119933941-fb420a00-bfbf-11eb-997f-c210827e2556.png)

---

class: center, middle

# 続きは GitHub で

Your contribution is welcome!

---

class: center, middle

# Appendix

開発者向け

---


# Usage (Part 1)

- Install Docker and Docker Compose. see the following link to learn more with your operating system:
  - [Install Docker Desktop on Windows](https://docs.docker.com/docker-for-windows/install/)
  - [Install Docker Desktop on Mac](https://docs.docker.com/docker-for-mac/install/)
  - [Get Docker Engine - Community for Ubuntu](https://docs.docker.com/install/linux/docker-ce/ubuntu/)

- To test out you've installed docker, just try:

```console
$ docker run --rm -it julia
# some staff happens ...
```

---

# Usage (Part 2)

```console
$ https://github.com/terasakisatoshi/MyWorkflow.jl.git
$ make
$ docker-compose up lab
Docker Compose is now in the Docker CLI, try `docker compose up`
Starting mylab ... done
Attaching to mylab
# some staff happens...
mylab      |
mylab      |     To access the server, open this file in a browser:
mylab      |         file:///root/.local/share/jupyter/runtime/jpserver-1-open.html
mylab      |     Or copy and paste one of these URLs:
mylab      |         http://1bafb42c152f:8888/lab?token=xxxxx...
mylab      |         http://127.0.0.1:8888/lab?token=xxxxx...
```

Open a Browser and go to `http://localhost:8888/lab?token=xxxxx...`


---

# Result

<img width="800" src="https://user-images.githubusercontent.com/16760547/119253138-c3ffe180-bbea-11eb-888b-424d5896f47e.png">

---

# Result (Gif)

<img width="800" src="https://user-images.githubusercontent.com/16760547/119253679-4f7a7200-bbed-11eb-812a-ac4bd50d5a5e.gif">

---

# DevContainer

<img width="800" alt="Screen Shot 2021-05-23 at 18 10 27" src="https://user-images.githubusercontent.com/16760547/119254700-d1b96500-bbf2-11eb-990d-7316a91d3961.png">

---

class: center, middle

# おちまい

- このスライドは https://terasakisatoshi.github.io/MathSeminar.jl/ からも閲覧することができます.
