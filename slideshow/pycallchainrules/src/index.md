class: center, middle

# PyCallChainRules.jl 入門

Flux.jl meets PyTorch

---

# 前置き

- ご存知の通り(?) Julia には Flux.jl という機械学習ライブラリがある. DeepLearning を行うための基本的なレイヤーが揃っている. でもなぜかあまりユーザーがいない.
    - A「だって，Python 便利だし」
      - 私「はい．．．」
    - B「みんな使ってるし PyTorch が便利なんだもーん」
      - 私「はい．．．」
    - C「機能いっぱい揃ってるしエコシステムが充実」
      - 私「はい．．．」

---

# PyCall がある（？！）

- 私「 PyCall.jl はそんな便利なライブラリを呼び出せる！ したがって Python は実質 Julia のライブラリです」
  - A 「ほほー，まぁ Torch.jl はあるらしいけれど動くんか？」
- 私 「Torch.jl の更新頻度は低く，GPU 環境でしか動作できないのでデバッグ大変で」
  - B 「まぁええわ．`torch = pyimport("torch")` でインポートして `torch.nn.Linear` を使えるんか」
- 私 「さようでございます」
  - C 「機械学習ちゅーんやから学習したいわな．んで微分計算どうするん？」
- 私 「Flux.jl が使う自動微分ライブラリ Zygote.jl は ChainRules.jl/ChainRulesCore.jl にある微分ルールをベースに微分演算を可能にします．ニューラルネットワークの微分ルールはNNlib.jl などで管理されており ChainRulesCore の拡張機能によってそれを可能にしています.」
  - D 「はーん？なら Python のオブジェクトに関しての微分ルールがないと無理ちゃうんか？」
- 私 「ぐーのねもでない」
---

class: center, middle

# ところがどっこい

[PyCallChainRules.jl](https://github.com/rejuvyesh/PyCallChainRules.jl)

---


# PyCallChainRules.jl 

> While Julia is great, there are still a lot of existing useful differentiable python code in PyTorch, Jax, etc. Given PyCall.jl is already so great and seamless, one might wonder what it takes to differentiate through those pycalls. This library aims for that ideal.

# つまり?

PyTorch のレイヤーを Julia から使える．それだけではなく Zygote.jl を使った自動微分が使える(なんやと．．．？！)

- このスライドでは v0.3.0 を試した速報スライドです.
- 2022/03/10 時点の話です

---

# Example

[リポジトリの例から抜粋](https://github.com/rejuvyesh/PyCallChainRules.jl#example)

```julia
using PyCallChainRules.Torch: TorchModuleWrapper, torch
using Zygote

indim = 32
outdim = 16
torch_module = torch.nn.Linear(indim, outdim) # Can be anything subclassing torch.nn.Module
jlwrap = TorchModuleWrapper(torch_module)

batchsize = 64
input = randn(Float32, indim, batchsize)
output = jlwrap(input)

target = randn(Float32, outdim, batchsize)
loss(m, x, y) = sum(m(x) .- target)
grad, = Zygote.gradient(m->loss(m, input, target), jlwrap)
```

`TorchModuleWrapper` 学習パラメータを持っているレイヤーをラップできている. `torch.nn.ReLU` はラップできないが Flux.jl の方でカバーできる.

---

class: center, middle

# Application

みんな大好き MNIST 学習 [Code is available](https://github.com/terasakisatoshi/PCRP.jl)

---

## Load Julia libraries

```julia
using Random

using Flux
using Flux.Data:DataLoader
using MLDatasets
using Images
using ProgressMeter
using PyCallChainRules.Torch: TorchModuleWrapper, torch

Base.@kwdef mutable struct Args
    η = 3e-4
    λ = 0
    batchsize=128
    epochs=5
    seed=12345
    use_cuda=false
end

args = Args()
Random.seed!(args.seed)
ENV["DATADEPS_ALWAYS_ACCEPT"] = true
```

---

## Prepare MNIST dataset 

```julia
using Flux
using Flux.Data: DataLoader
using MLDatasets

xtrain, ytrain = MLDatasets.MNIST.traindata(Float32)
xtest, ytest = MLDatasets.MNIST.testdata(Float32)
xtrain = Flux.unsqueeze(xtrain, 3) # (28, 28, 60000) -> (28, 28, 1 , 60000)
xtest = Flux.unsqueeze(xtest, 3)   # (28, 28, 10000) -> (28, 28, 1, 10000)
ytrain = Flux.onehotbatch(ytrain, 0:9) # (60000,) -> (10, 60000)
ytest = Flux.onehotbatch(ytest, 0:9)   # (10000,) -> (10, 10000)
train_loader = DataLoader((xtrain, ytrain), batchsize=128, shuffle=true)
test_loader = DataLoader((xtest, ytest),  batchsize=128);
```

---

## [Create LeNet](https://github.com/FluxML/model-zoo/tree/master/vision/conv_mnist)

```julia
struct LeNet
    cnn_layer
    mlp_layer
    nclasses
end

Flux.@functor LeNet (cnn_layer, mlp_layer) # cnn_layer と mlp_layer が学習パラメータであることを指定する

(net::LeNet)(x) = x |> net.cnn_layer |> flatten |> net.mlp_layer
```

ここまでは Flux.jl と同じ

---

## Constructor

```julia
function create_model(imsize::Tuple{Int,Int,Int}, nclasses::Int)
    W, H, inC = imsize
    out_conv_size = (W ÷ 4 - 3, H ÷ 4 - 3, 16)
    cnn_layer = Chain(
        TorchModuleWrapper(torch.nn.Conv2d(1, 6, (5,5))), # PyTorch
        x->Flux.relu.(x), # Flux
        MaxPool((2,2)), # Flux
        TorchModuleWrapper(torch.nn.Conv2d(6, 16, (5,5))), # PyTorch
        x->Flux.relu.(x), # Flux
        MaxPool((2,2)) # Flux
    )
    mlp_layer = Chain(
        TorchModuleWrapper(torch.nn.Linear(prod(out_conv_size), 120)), # PyTorch
        x->Flux.relu.(x), # Flux
        TorchModuleWrapper(torch.nn.Linear(120, 84)), # PyTorch
        x->Flux.relu.(x), # Flux
        TorchModuleWrapper(torch.nn.Linear(84,nclasses)), # PyTorch
    )
    LeNet(cnn_layer, mlp_layer, nclasses) # Julia struct
end
```

これでできる...

---

```julia
model = create_model((28, 28, 1), 10) |> f32
ps = Flux.params(model);
opt = Descent(0.05)
loss(ŷ, y) = Flux.Losses.logitcrossentropy(ŷ, y)

# Training loop
for e in 1:args.epochs
    @showprogress for (x, y) in train_loader
        gs, = Flux.gradient(model) do m
            ŷ = m(x)
            loss(ŷ, y)
        end
        cnt = 1
        for g in gs
            isnothing(g) && continue
            for lay in g.layers
                isnothing(lay) && continue
                for Δ in lay.params
                    #@show Δ
                    ps[cnt] .-= Flux.Optimise.apply!(opt, ps[cnt], Δ)
                    cnt += 1
                end
            end
        end
    end
    acc = sum(Flux.onecold(model(xtest)) .== Flux.onecold(ytest))
    acc /= size(ytest, 2)
    @info("acc", 100acc, "%")
end
```

---

# Result

できたできゅ！

<img width="500" alt="image" src="https://user-images.githubusercontent.com/16760547/157697417-997134de-6d2b-4d8b-b4a7-d028350100a2.png">

---

Flux.jl お作法と完全にコンパチブルではない. よって `Optimise.update!` を使うことができない.

色々デバックした結果，下記のようにループを書いて対応させると良さそう(?)
もうちょっとスマートに描ければ素敵

```julia
gs, = Flux.gradient(model) do m
    ŷ = m(x)
    loss(ŷ, y)
end
cnt = 1
for g in gs
    isnothing(g) && continue
    for lay in g.layers
        isnothing(lay) && continue
        for Δ in lay.params
            #@show Δ
            ps[cnt] .-= Flux.Optimise.apply!(opt, ps, Δ)
            cnt += 1
        end
    end
end
```

---

# Question

- GPU でも使える？
  - functorch がビルドできればOK. 2 週間前に動作を確認.
  - 安定化は今後期待される
- `Chain(Flux 畳み込み, Torch の畳み込み)` はできる？
  - 割り切って Torch だけで書くというのはアリ？
  - ~~forward 計算はできるけれど Flux.gradient のインターフェースの統一が不十分.~~
    - こちらの[問題は解決されました](https://github.com/rejuvyesh/PyCallChainRules.jl/blob/main/examples/simpleflux/train_ml_mix_explicit.jl)．
  - ゆーて PyCallChainRules は v0.3.x なので今後に期待.
  - 実用に向けてIssueで議論が行われている．

---

# Appendix

コードはここに置いておきます.

https://github.com/terasakisatoshi/PCRP.jl





