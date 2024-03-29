class: center, middle
# Dash.jl で遊ぼう
ごまふあざらし

---


# Dash.jl とは 
- Web アプリを構築する Python フレームワーク Dash の Julia 版
- 単純に Python の Dash を PyCall.jl で wrap したものではなく直接 Julia と JS が連携してる.
  - JS はフロントエンドライブラリの React が裏で動いている.

---

# Remark (2022 年3月追記)

このスライドは 2020 年に作成されました．今日では既に過去遺物になり Dash.jl 側の仕様で一部のコードが動かないです. （泣）
例えば Plots.jl を経由して得られた描画オブジェクトを利用するハックは JSON.jl と JSON3.jl などの兼ね合いでランタイムエラーが発生します．

`DashCoreComponents`, `DashHtmlComponents` などと書かれている部分は今日では不要になりました. (Python API 側も同様です.)

---

# このスライドを読んでわかること

- 関数 $y=x^n$ の $n$ を変化させたときの様子を描画する例を Julia で書ける.
<div style="text-align:center;">
<img height=350 src=https://user-images.githubusercontent.com/16760547/89501959-2e33cb00-d7ff-11ea-85e0-17dff0fcaf3f.gif />
</div>


---

# Install
- Dash.jl の README.md に従えば良い.
- Python での dash_core_components などは対応するリポジトリの `jl` ブランチで管理されている

```julia
julia> using Pkg
julia> Pkg.add(["Dash"]) # 昔は DashCoreComponents があったけれど今はいらなくなった
```
---

# Usage
- `sample.jl` を作って `julia sample.jl` を実行すれば良い. `sample.jl` を適宜編集すると自動で反映される.
```julia
# sample.jl: Dash.jl の README.md から引用
using Dash
app = dash(external_stylesheets = ["https://codepen.io/chriddyp/pen/bWLwgP.css"])
app.layout = html_div() do
    html_h1("Hello Dash"),
    html_div("Dash.jl: Julia interface for Dash"),
    dcc_graph(
        id = "example-graph",
        figure = (
            data = [
                (x = [1, 2, 3], y = [4, 1, 2], type = "bar", name = "SF"),
                (x = [1, 2, 3], y = [2, 4, 5], type = "bar", name = "Montréal"),
            ],
            layout = (title = "Dash Data Visualization",),
        ),
    )
end

run_server(app, "127.0.0.1", 8050, debug = true) # localhost:8050 にアクセス
```

---


# Result
<div style="text-align:center;">
    <img height=400 src=https://user-images.githubusercontent.com/16760547/89650605-a97ba680-d8fd-11ea-8110-9751b9e179d4.png />
</div>
- See my gist [here](https://gist.github.com/terasakisatoshi/b3113fbb290a00650d0e81a1f00c7fab)


---


# Appendix (Python)

```python
# Reference: https://dash.plotly.com/dash-core-components/graph
import dash
import dash_core_components as dcc
import dash_html_components as html

app = dash.Dash(__name__, external_stylesheets=["https://codepen.io/chriddyp/pen/bWLwgP.css"])

app.layout = html.Div(
    children=[
        html.H1(children="Hello Dash",),
        html.Div(children="Dash: A web application framework for Python/R/Julia",),
        dcc.Graph(
            id="example-graph",
            figure={
                "data": [
                    {"x": [1, 2, 3], "y": [4, 1, 2], "type": "bar", "name": "SF"},
                    {"x": [1, 2, 3], "y": [2, 4, 5], "type": "bar", "name": u"Montréal"},
                ],
                "layout": {"title": "Dash Data Visualization"},
            },
        ),
    ],
)

if __name__ == "__main__":
    app.run_server(debug=True)

```

---


# Syntax (Python vs. Julia)


```python
# Python
import dash
import dash_core_components as dcc
import dash_html_components as html
app = dash.Dash(__name__, external_stylesheets=["https://codepen.io/chriddyp/pen/bWLwgP.css"])
app.layout = html.Div(
    children=[
        html.Xyz(...),
        html.Xyz(...),
        dcc.Xyz(...),
    ],
)
```

`do`-syntax を利用する. `Python`->`Julia` の翻訳は `html.Div` -> `html_div` や `dcc.Graph` -> `dcc_graph` のようにする.


```julia
# Julia
using Dash
using DashCoreComponents
using DashHtmlComponents
app = dash(external_stylesheets = ["https://codepen.io/chriddyp/pen/bWLwgP.css"])
app.layout = html_div() do
    html_xyz(...), # 各コンポーネントは
    html_xyz(...), # `,` で区切る
    dcc_xyz(...) # 注意！！！最後は `,` を入れてはいけない. 
end
```

---

# `dcc_graph(figure=...)`
- `:data`, `:layout` をキーにもつ NamedTuple 
- PlotlyJS で作成したオブジェクト
```julia
using PlotlyJS
p = plot([1, 2, 3])
p |> typeof |> print # PlotlyJS.SyncPlot 
# 注意!!! この `p` を `figure` に渡さない
dcc_graph(figure=p.plot) # p.plot を渡す
```

- Plots.jl で作成したオブジェクトを PlotlyJS に変換する API を利用する (個人的におすすめ)

```julia
using Plots

function powplot(n)
    p = plot(x -> x^n, label = "y=x^$n", xlims=[0,1])
    # NamedTuple を作る
    return (data = Plots.plotly_series(p), layout = Plots.plotly_layout(p))
end

dcc_graph(figure=powplot(3))
```

---


# callback!


- Python の `@app.callback` に対応.
- 関数 $y=x^n$ をプロットする冒頭のデモのコードを例に ([Dash.jl/Contributed Examples #50](https://github.com/plotly/Dash.jl/issues/50))


```julia
function powplot(n)
    p = plot(x -> x^n, label = "y=x^$n", xlims=[0,1])
    return (data = Plots.plotly_series(p), layout = Plots.plotly_layout(p))
end
app = dash(external_stylesheets = ["https://codepen.io/chriddyp/pen/bWLwgP.css"])
app.layout = html_div(style = Dict(:width => "50%")) do
    html_h1("Hello Dash"),
    html_div() do
        html_div("slider", style = (width = "10%", display = "inline-block")),
        html_div(dcc_slider(
            id = "slider",
            min = 0, max = 9, marks = Dict(i => "$i" for i = 0:9), value = 1,
        ),style = (width = "70%", display = "inline-block"))
    end,
    html_br(),
    dcc_graph(id = "graph", figure = powplot(1))
end

callback!(app, Output("graph", "figure"), Input("slider", "value")) do value
   powplot(value)
end
```

---


# Example を作っていこう


- https://github.com/plotly/Dash.jl/issues/50 に Example を奉納する Issue を作った
- Plots.jl を使って `(data = Plots.plotly_series(p), layout = Plots.plotly_layout(p))` のスタイルが入門しやすいと思う.
- このスライドと下記の gist をさわれば入門の意味で完全に理解できる.
## gist 
- [Julia vs. Python](https://gist.github.com/terasakisatoshi/b3113fbb290a00650d0e81a1f00c7fab)
- [dcc_slider の例](https://gist.github.com/terasakisatoshi/8c47b12a6997a3e0f64613f4aa33d422)
- [dcc_xxx の例](https://gist.github.com/terasakisatoshi/da31ab840ac8cc496b8af0ac157141b7)
- [PlotlyJS.jl/Plots.jl の例](https://gist.github.com/terasakisatoshi/257e48af35f629dc34ba896989ba658f)


---


class: center, middle
# おちまい
ごまふあざらし

---

class: center, middle
# Dash(.jl) のためのコンポーネントを作ろう.
ごまふあざらし

---

# ここで述べること

- Dash.jl で使える UI を自作する方法
  - 実際には Julia に限らず Python, R でも適用できる．
  - Dash では UI をコンポーネント(=Component) と呼んでいる
  - [dash-component-boilerplate](https://github.com/plotly/dash-component-boilerplate) を使う.
- 対象:
  - Dash が提供する既存のコンポーネントで満足できない人向け

---

# Example

- JSXGraph を表示する
- 他のコンポーネントと連携する
<div class="center">
    <img width="800" alt="Screen Shot 2021-05-12 at 17 51 30" src="https://user-images.githubusercontent.com/16760547/117947558-4535b980-b34b-11eb-84c9-aad97442cf4d.png">
</div>

---

# 必要なソフトウェア

- Julia
  - ですよね？
- Python 
  - ツールとして必要
  - `cookiecutter`, `virtualenv`
- NodeJS, npm
  - [dash-component-boilerplate](https://github.com/plotly/dash-component-boilerplate) プロジェクトのビルドに使う
  - JavaScript を動作させるランタイム環境. ブラウザ以外の環境でも動かせるようになった.
  - コンポーネントの記述に React を使う
  - Python の文法を知っていれば雰囲気で押し進めることができる.
  - npm は JavaScript のパッケージマネージャ(Python の pip みたいなもの)
  - Python ユーザーは [React for Python Developers: a primer](https://dash.plotly.com/react-for-python-developers) を見ると理解しやすい.

---

# Install (NodeJS, npm)

- `npm` コマンドが使えれば良い. 導入はお好きなように
- 例えば [anyenv](https://github.com/anyenv/anyenv) を経由して導入する方法がある. macOS ユーザーの場合は次のようにする:

```console
% brew install anyenv
% echo 'eval "$(anyenv init -)"' >> ~/.zshrc
% exec $SHELL -l
% anyenv install nodenv # ここを pyenv にするとPython, renv にすると R が入る.
% exec $SHELL -l
% nodenv install 14.4.0
% nodenv global 14.4.0
% node --version
v14.4.0
% npm --version
7.12.0
```

- 導入は [くるみ割り書房 ft. React](https://oukayuka.booth.pm/) から引用
- anyenv については [rinpa さんの Qiita 記事 `anyenv + macOS環境構築`](https://qiita.com/rinpa/items/81766cd6a7b23dea9f3c) が詳しい.

---

class: center, middle
# Intro to NodeJS (忙しい人向け)

---

# Intro to NodeJS (Console)

## REPL

```console
$ node
> "Hello World"
'Hello World'
```

## Execute an external JS file

```console
$ echo 'console.log("Hello World")' > hello.js
$ node hello.js
Hello World
```

---

# Intro to NodeJS (Syntax Part 1)

```js
// 変数の宣言
let x = 1;
let y = 1;
console.log(x + y); // 2
x = -1 // 再代入できる
console.log(x + y); // 0
let g = "goma"; // string
// const を用いて再代入できないようする
const theorem = `${g} is cute`; // template strings
console.log(theorem) // goma is cute
// データ構造
const lang = ["Julia", "Python", "R"];
console.log(lang[0]); // 'Julia'
let myTechStack = {
  deeplearning: "PyTorch",
  frontend: "React",
  web: "Dash",
  backend: "Julia",
}
console.log(myTechStack.deeplearning) // 'PyTorch'
console.log(myTechStack["web"]) // 'Dash'
```

---

# Intro to NodeJS (Syntax Part 2)

```js
// calcpi.js
class PiSimulator {
    constructor(N) {
        this.N = N;
    }

    calcPi() {
        let s = 0;
        for (let i = 0; i < this.N; i++) {
            const x = Math.random();
            const y = Math.random();
            if (x ** 2 + y ** 2 < 1) {
                s += 1;
            }
        }
        const pi_approx = 4 * s / this.N;
        return pi_approx;
    }
}

const N = 10000000;
const simulator = new PiSimulator(N);
console.log(simulator.calcPi()); # だいたい円周率に近くなる
```

---

# Intro to NodeJS (Appendix)

- I want to run NodeJS on Jupyter Notebook to learn...

```console
$ git clone https://github.com/terasakisatoshi/jsexample
$ cd myjsexample
$ docker-compose build
$ docker-compose up lab
jsexample | [C 2021-05-12 11:09:58.249 ServerApp]
jsexample |
jsexample |     To access the server, open this file in a browser:
jsexample |         file:///root/.local/share/jupyter/runtime/jpserver-1-open.html
jsexample |     Or copy and paste one of these URLs:
jsexample |         http://8279f5e3fd2d:8888/lab?token=xxxxxxx
jsexample |         http://127.0.0.1:8888/lab?token=xxxxxxx
```

---

class: center, middle
# Intro to React (忙しい人向け)

---

# What is React ?

- UI を記述するための JS ライブラリ.
- Component という単位で UI を構築しそれらを組み合わせる.
  - JSX (JS, ECMAScript 2015 に対する拡張構文).

```babel
class HelloMessage extends React.Component {
  render() {
    return (
      <div> 
        Hello {this.props.name} // name というプロパティの値を用いる
      </div>
    );
  }
}

ReactDOM.render(
  <HelloMessage name="Taylor" />, // name はプロパティと呼ばれる.
  document.getElementById('hello-example')
);
```

---

# React 

https://reactjs.org/ トップページで

---

# React (single HTML)

- HTML のコードを貼ると技術的な問題でスライドが崩れるので画像で ^^;
- 参考: https://www.taniarascia.com/getting-started-with-react/

<div class="center">
    <img width="700" alt="Screen Shot 2021-05-12 at 20 35 50" src="https://user-images.githubusercontent.com/16760547/117968965-c1d39280-b361-11eb-9876-2f2ebde70f65.png">
</div>

---

# React via `create-react-app`

- 雛形を作ってくれる.

```console
$ npm install -g npx # npx がなければ実行 yarn を入れても良い
$ npx create-react-app my-app
$ cd my-app
$ npm start
```

---

# Dash and React


- Dash は React で記述したコンポーネントをラップしている
  - (気合を入れたら) React でできることは Dash でもできることになる

- [コード](https://github.com/plotly/dash-core-components/tree/dev/src/components) を見ると React を用いていることがわかる．

---

# Create your Custom Component

- 我々は React と Dash の関係を理解したので作っていくことにします.

### 題材 ([JSXGraph](https://jsxgraph.uni-bayreuth.de/wp/index.html))

- SXGraph is implemented in pure JavaScript, does not rely on any other library, and uses SVG, VML, or canvas. Special care has been taken to optimize the performance.

---

# Getting Started (Part 1)

- 下記を実行(ちょっと時間がかかる)

```console
$ pip install cookiecutter virtualenv
$ cookiecutter https://github.com/plotly/dash-component-boilerplate.git
project_name [my dash component]: my jsxgraph component
project_shortname [my_jsxgraph_component]:
component_name [MyJsxgraphComponent]:
jl_prefix []: dash
r_prefix []: dash
author_name [Enter your first and last name (For package.json)]: <各自の名前>
author_email [Enter your email (For package.json)]: <各自のEmail>
github_org []:
description [Project Description]: goma
Select license:
1 - MIT License
2 - BSD License
3 - ISC License
4 - Apache Software License 2.0
5 - GNU General Public License v3
6 - Not open source
Choose from 1, 2, 3, 4, 5, 6 [1]: 1
publish_on_npm [True]: True
install_dependencies [True]: True
```


---

# Getting Started (Part 2)

- プロジェクトの雛形が出来上がる. 名前などは `package.json` を作るために用いる.
- `jl_prefix` をスキップすると何故かダメっぽい．．．ので何かつけておく

```console
Executing: venv/bin/python -m dash.development.component_generator ./src/lib/components my_dash_component -p package-info.json --jl-prefix 'dash' --r-prefix 'dash'
Generated MyDashComponent.py 
Generated dashMyDashComponent.R
Generated dash_mydashcomponent.jl
Generated src/MyDashComponent.jl
Generated Project.toml

my_dash_component ready!
```

---

# Getting Started (Part 3)


```console
$ cd my_dash_component # 雛形プロジェクトに移動
$ . venv/bin/activate
$ python usage.py
Dash is running on http://127.0.0.1:8050/

 * Serving Flask app 'usage' (lazy loading)
 * Environment: production
   WARNING: This is a development server. Do not use it in a production deployment.
   Use a production WSGI server instead.
 * Debug mode: on
```

# Result

<img width="395" alt="Screen Shot 2021-05-12 at 21 53 08" src="https://user-images.githubusercontent.com/16760547/117978243-a326c900-b36c-11eb-9724-0f495bbe41a3.png">

---


# Utilize component from Julia
```console
$ julia --project=@. -e 'using Pkg; Pkg.add(["Dash", "DashCoreComponents", "DashHtmlComponents"])'
$ cat app.jl # please create it by yourself
using Dash, DashHtmlComponents, DashCoreComponents
using MyDashComponent

app = dash(external_stylesheets = ["https://codepen.io/chriddyp/pen/bWLwgP.css"])

app.layout = html_div() do
        html_h1("Hello Dash"),
        html_div("Dash.jl: Julia interface for Dash"),
        dcc_input(id = "input", value="initial value", type = "text"),
        html_br(),
        dash_mydashcomponent(id="mycomponent", value="これは価値です(駄洒落)"),
        html_div("", id="inner-div")
    end

callback!(app, Output("mycomponent", "value"), Input("input", "value")) do v
    v
end

callback!(app, Output("inner-div", "children"), Input("mycomponent", "value")) do input_value
    input_value
end

run_server(app, "0.0.0.0", 8080, debug=true)
$ julia --project=@. app.jl
```

---

# Result

<img width="363" alt="Screen Shot 2021-05-12 at 22 09 49" src="https://user-images.githubusercontent.com/16760547/117980367-dc603880-b36e-11eb-9f0d-28ab54eb6291.png">

---

## ExampleComponent

- `src/lib/components/MyDashComponent.react.js` 

```babel
import React, {Component} from 'react';
import PropTypes from 'prop-types';
export default class MyDashComponent extends Component {
    render() {
        const {id, label, setProps, value} = this.props;
        return (
            <div id={id}>
                ExampleComponent: {label}&nbsp;
                <input
                    value={value}
                    onChange={
                        e => setProps({ value: e.target.value })
                    }
                />
            </div>
        );
    }
}
MyDashComponent.defaultProps = {};
MyDashComponent.propTypes = {
    id: PropTypes.string,
    label: PropTypes.string.isRequired,
    value: PropTypes.string,
    setProps: PropTypes.func
};
```

---

# Workflow

- 色々いじって試してみよう. JS コードを編集したら下記を実行することをお忘れなく.

```console
$ npm run build
```

- jsxgraph ライブラリをインストールする

```console
$ npm install jsxgraph
```

## callback! との連携

```js
componentDidUpdate(prevProps, prevState) { // Dash 側からの変更を検知
    this.props.setProps(// Dash 側で自動的に付与されるメソッド
      {value: this.props.example.toString()} // 更新を Dash 側に通知
    )
}
```


---

# [Example](https://github.com/terasakisatoshi/my-jsxgraph-component.git)

```console
$ git clone https://github.com/terasakisatoshi/my-jsxgraph-component.git
$ cd my-jsxgraph-component
$ npm install
$ julia -e 'using Pkg; Pkg.add(["Dash", "DashCoreComponents", "DashHtmlComponents"])'
$ julia --project=@. -e 'using Pkg; Pkg.instantiate()'
$ julia --project=@. app.jl
```

## Result

<div class="center">
    <img width="400" alt="Screen Shot 2021-05-12 at 17 51 30" src="https://user-images.githubusercontent.com/16760547/117947558-4535b980-b34b-11eb-84c9-aad97442cf4d.png">
</div>

--- 

class: center, middle
# おちまい