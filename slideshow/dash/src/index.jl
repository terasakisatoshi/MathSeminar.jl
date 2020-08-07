# class: center, middle
# # Dash.jl で遊ぼう
# ごまふあざらし

# ---

# # Dash.jl とは 
# - Web アプリを構築する Python フレームワーク Dash の Julia 版
# - 単純に Python の Dash を PyCall.jl で wrap したものではなく直接 Julia と JS が連携してるっぽい
# - 開発ステータスは WIP だが Plotly 本家の チュートリアルの機能は揃ってそう
# - 関数 $y=x^n$ の $n$ を変化させたときの様子を描画する例を Julia で書いた
# <div style="text-align:center;">
# <img height=350 src=https://user-images.githubusercontent.com/16760547/89501959-2e33cb00-d7ff-11ea-85e0-17dff0fcaf3f.gif />
# </div>

# ---

# # Install
# - Dash.jl の README.md に従えば良い.
# - Python での dash_core_components などは対応するリポジトリの `jl` ブランチで管理されている
# ```julia
# using 
# # using Dash
# Pkg.add(PackageSpec(url="https://github.com/plotly/Dash.jl.git", rev="dev"))
# # using DashCoreComponents
# Pkg.add(PackageSpec(url="https://github.com/plotly/dash-html-components.git", rev="jl"))
# # using DashHtmlComponents
# Pkg.add(PackageSpec(url="https://github.com/plotly/dash-core-components.git", rev="jl"))
# # using DashTable
# Pkg.add(PackageSpec(url="https://github.com/plotly/dash-table.git", rev="jl"))
# ```
# 
#
# |  Julia       |  Python  |
# | :---         | :---     |
# |  `using Dash`  |  `import dash`  |
# |  `using DashCoreComponents` | `import dash_core_components  as dcc`  |
# |  `using DashHtmlComponents` | `import dash_html_components  as html` |
# |  `using DashTable`          | `import dash_table` |

# ---

# # Usage
# - Dash.jl の README.md から引用
# ```julia
# # sample.jl
# using Dash
# using DashCoreComponents
# using DashHtmlComponents
# app = dash(external_stylesheets = ["https://codepen.io/chriddyp/pen/bWLwgP.css"])
# app.layout = html_div() do
#     html_h1("Hello Dash"),
#     html_div("Dash.jl: Julia interface for Dash"),
#     dcc_graph(
#         id = "example-graph",
#         figure = (
#             data = [
#                 (x = [1, 2, 3], y = [4, 1, 2], type = "bar", name = "SF"),
#                 (x = [1, 2, 3], y = [2, 4, 5], type = "bar", name = "Montréal"),
#             ],
#             layout = (title = "Dash Data Visualization",),
#         ),
#     )
# end
# 
# run_server(app, "127.0.0.1", 8050, debug = true) # localhost:8050 にアクセス
# ```

# - `julia sample.jl` を実行すれば良い. `sample.jl` を適宜編集すると自動で反映される

# ---

# # Result
# <div style="text-align:center;">
#     <img height=400 src=https://user-images.githubusercontent.com/16760547/89650605-a97ba680-d8fd-11ea-8110-9751b9e179d4.png />
# </div>
# - See my gist [here](https://gist.github.com/terasakisatoshi/b3113fbb290a00650d0e81a1f00c7fab)

# ---

# # Appendix (Python)

# ```python
# # Reference: https://dash.plotly.com/dash-core-components/graph
# import dash
# import dash_core_components as dcc
# import dash_html_components as html
# 
# app = dash.Dash(__name__, external_stylesheets=["https://codepen.io/chriddyp/pen/bWLwgP.css"])
# 
# app.layout = html.Div(
#     children=[
#         html.H1(children="Hello Dash",),
#         html.Div(children="Dash: A web application framework for Python/R/Julia",),
#         dcc.Graph(
#             id="example-graph",
#             figure={
#                 "data": [
#                     {"x": [1, 2, 3], "y": [4, 1, 2], "type": "bar", "name": "SF"},
#                     {"x": [1, 2, 3], "y": [2, 4, 5], "type": "bar", "name": u"Montréal"},
#                 ],
#                 "layout": {"title": "Dash Data Visualization"},
#             },
#         ),
#     ],
# )
# 
# if __name__ == "__main__":
#     app.run_server(debug=True)
# 
# ```

# ---

# # Syntax (Python vs. Julia)
# 

# ```python
# # Python
# import dash
# import dash_core_components as dcc
# import dash_html_components as html
# app = dash.Dash(__name__, external_stylesheets=["https://codepen.io/chriddyp/pen/bWLwgP.css"])
# app.layout = html.Div(
#     children=[
#         html.Xyz(...),
#         html.Xyz(...),
#         dcc.Xyz(...),
#     ],
# )
# ```

# `do`-syntax を利用する. `Python`->`Julia` の翻訳は `html.Div` -> `html_div` や `dcc.Graph` -> `dcc_graph` のようにする.


# ```julia
# # Julia
# using Dash
# using DashCoreComponents
# using DashHtmlComponents
# app = dash(external_stylesheets = ["https://codepen.io/chriddyp/pen/bWLwgP.css"])
# app.layout = html_div() do
#     html_xyz(...), # 各コンポーネントは
#     html_xyz(...), # `,` で区切る
#     dcc_xyz(...) # 注意！！！最後は `,` を入れてはいけない. 
# end
# ```

# ---

# # `dcc_graph(figure=...)`
# - `:data`, `:layout` をキーにもつ NamedTuple 
# - PlotlyJS で作成したオブジェクト
# ```julia
# using PlotlyJS
# p = plot([1, 2, 3])
# p |> typeof |> print # PlotlyJS.SyncPlot 
# # 注意!!! この `p` を `figure` に渡さない
# dcc_graph(figure=p.plot) # p.plot を渡す
# ```

# - Plots.jl で作成したオブジェクトを PlotlyJS に変換する API を利用する (個人的におすすめ)

# ```julia
# using Plots
# 
# function powplot(n)
#     p = plot(x -> x^n, label = "y=x^$n", xlims=[0,1])
#     # NamedTuple を作る
#     return (data = Plots.plotly_series(p), layout = Plots.plotly_layout(p))
# end
# 
# dcc_graph(figure=powplot(3))
# ```

# ---

# # callback!

# - Python の `@app.callback` に対応.
# - 関数 $y=x^n$ をプロットする冒頭のデモのコードを例に ([Dash.jl/Contributed Examples #50](https://github.com/plotly/Dash.jl/issues/50))


# ```julia
# function powplot(n)
#     p = plot(x -> x^n, label = "y=x^$n", xlims=[0,1])
#     return (data = Plots.plotly_series(p), layout = Plots.plotly_layout(p))
# end
# app = dash(external_stylesheets = ["https://codepen.io/chriddyp/pen/bWLwgP.css"])
# app.layout = html_div(style = Dict(:width => "50%")) do
#     html_h1("Hello Dash"),
#     html_div() do
#         html_div("slider", style = (width = "10%", display = "inline-block")),
#         html_div(dcc_slider(
#             id = "slider",
#             min = 0, max = 9, marks = Dict(i => "$i" for i = 0:9), value = 1,
#         ),style = (width = "70%", display = "inline-block"))
#     end,
#     html_br(),
#     dcc_graph(id = "graph", figure = powplot(1))
# end
# 
# callback!(app, Output("graph", "figure"), Input("slider", "value")) do value
#    powplot(value)
# end
# ```

# ---

# # Example を作っていこう

# - https://github.com/plotly/Dash.jl/issues/50 に Example を奉納する Issue を作った
# - Plots.jl を使って `(data = Plots.plotly_series(p), layout = Plots.plotly_layout(p))` のスタイルが入門しやすいと思う.
# - このスライドと下記の gist をさわれば入門の意味で完全に理解できる.
# ## gist 
# - [Julia vs. Python](https://gist.github.com/terasakisatoshi/b3113fbb290a00650d0e81a1f00c7fab)
# - [dcc_slider の例](https://gist.github.com/terasakisatoshi/8c47b12a6997a3e0f64613f4aa33d422)
# - [dcc_xxx の例](https://gist.github.com/terasakisatoshi/da31ab840ac8cc496b8af0ac157141b7)
# - [PlotlyJS.jl/Plots.jl の例](https://gist.github.com/terasakisatoshi/257e48af35f629dc34ba896989ba658f)

#  ---

# class: center, middle
# # おちまい
# ごまふあざらし