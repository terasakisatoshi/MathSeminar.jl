class: center, middle

# [Replay.jl](https://github.com/AtelierArith/Replay.jl) 入門

ごまふあざらし

---

# [Replay.jl](https://github.com/AtelierArith/Replay.jl) でなにができるの？

- Julia の REPL での操作を再現する機能を提供
- 文法の説明だったり, REPL でのデモを行うときに便利

## Example

```julia
$ julia
               _
   _       _ _(_)_     |  Documentation: https://docs.julialang.org
  (_)     | (_) (_)    |
   _ _   _| |_  __ _   |  Type "?" for help, "]?" for Pkg help.
  | | | | | | |/ _` |  |
  | | |_| | | | (_| |  |  Version 1.7.2 (2022-02-06)
 _/ |\__'_|_|_|\__'_|  |  Official https://julialang.org/ release
|__/                   |

julia> println("Why We Created Julia")
julia> println("In short, because we are greedy.")
```

- See [Why We Created Julia](https://julialang.org/blog/2012/02/why-we-created-julia/)

---

# 実演

<div style="text-align:center;">
  <video width="750" controls autoplay>
    <source src="https://user-images.githubusercontent.com/16760547/170237445-321fffb2-eb58-4842-84d4-8679d640f8dd.mov">
  </video>
</div>

---

# なにが起きた？

- 下記のコードをファイルに書いて実行するだけ

```julia
using Replay
instructions = [
    "println(\"Why We Created Julia\")",
    "println(\"In short, because we are greedy.\")",
]
replay(instructions, use_ghostwriter=true)
```

- `use_ghostwriter` はカタカタとタイピングを実行するように演出するオプション

---

# 複数行からなる命令

- 円周率を計算する例

<div style="text-align:center;">
  <video width="750" controls autoplay>
    <source src="https://user-images.githubusercontent.com/16760547/170244402-cb681989-4b77-4adb-b6d3-2f3719a03a10.mov">
  </video>
</div>

---


# 複数行からなる命令（種明かし）

```julia
using Replay

instructions = [
"""
function calcπ(N)
  cnt = 0
  for a = 1:N, b = 1:N
      cnt += ifelse(gcd(a, b) == 1, 1, 0)
  end
  prob = cnt / N / N
  √(6 / prob)
end
"""
,
"@time calcπ(10^4)",
]
replay(instructions, use_ghostwriter=true)
```

---


# 動作原理

- メインの(Juliaの)プロセス: カタカタと入力する描画を担当
- 裏で動くもう一人の Julia:
  - メインのプロセスから入力を受け取る
  - 評価
  - 出力をメインに返す
- メインプロセス側で結果を表示

詳しくは

https://github.com/AtelierArith/Replay.jl

を見てください.


---

class: center, middle

# 再生ができるなら録画もしたいじゃない！

できるよ！

---

# Asciinema

```console
$ git clone https://github.com/AtelierArith/Replay.jl.git
$ cd Replay.jl
$ julia --project=@. -e 'using Pkg; Pkg.instantiate()'
$ asciinema rec result.cast --command "julia --project=@. ./examples/readme/app.jl"
$ asciinema play output.cast
```

<a href="https://asciinema.org/a/WeyJwfjliWRSzliWMnbBQNtJP" target="_blank"><img width="1000" src="https://asciinema.org/a/WeyJwfjliWRSzliWMnbBQNtJP.svg" /></a>

[解説はこちら](https://zenn.dev/terasakisatoshi/articles/c87263695fac4f)


---

# screencapture (macOS 限定で)

今までのデモ動画は実はこのパッケージで作成してました．

```console
$ git clone https://github.com/terasakisatoshi/QuartzGetWindow.jl.git
$ julia --project=@. -e 'using Pkg; Pkg.instantiate()'
$ julia --project=@. src/demo.jl
```

<div style="text-align:center;">
  <video width="550" controls autoplay>
    <source src="https://user-images.githubusercontent.com/16760547/164014359-257d6c48-a952-4a9a-8568-6b16d6bfe0ab.mov">
  </video>
</div>


