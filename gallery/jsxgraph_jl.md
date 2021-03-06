@def title = "JSXGraph.jl"
@def hasjsx = true


\toc

\initcounter{}

\chapter{JSXGraph.jl}

- JSXGraph.jl aims to help generate JSXGraph code from Julia code that can then be plugged in a statically served website.

- Checkout [JSXGraph.jl's official documentation](https://tlienart.github.io/JSXGraphWeb/). Of course this website built with [Franklin.jl](https://github.com/tlienart/Franklin.jl).

\chapter{Install Package}

- Simply to run:

```julia-repl
julia> using Pkg; Pkg.add("JSXGraph")
julia> using JSXGraph
```

\chapter{Insert secret ingredient}

- O.K. how do I embed the result of JSXGraph.jl ?
- Like making delicious curry rice, we need several spices.

\section{insert `JSXGraph.PREAMBLE`}

- According to the [index.md of https://github.com/tlienart/JSXGraphWeb](https://github.com/tlienart/JSXGraphWeb/blob/master/index.md), we need inject raw HTML consisted of the output of `<script>$(JSXGraph.PREAMBLE)</script>`. Namely, insert the following code before writing your Julia code w.r.t JSXGraph.

<!-- generated via
```julia-repl
julia> using Markdown; Markdown.htmlesc(raw"<script>$(JSXGraph.PREAMBLE)</script>")
```
 -->
`````markdown
```julia:preamble
# Insert secret ingredient. It is not a trade secret since Franklin is OSS.
println(~~~&lt;script&gt;&#36;&#40;JSXGraph.PREAMBLE&#41;&lt;/script&gt;~~~)
```
\textoutput&#123;preamble&#125;
`````

<!-- Shadow warrior -->
```julia:prepare
#hideall
using JSXGraph
println("~~~<script>$(JSXGraph.PREAMBLE)</script>~~~")
```
\textoutput{prepare}
<!-- End of Shadow warrior -->

\section{Edit `_layout/head.html`}

- Copy `jsx` directory from [ https://github.com/tlienart/JSXGraphWeb/tree/master/_libs/jsx](https://github.com/tlienart/JSXGraphWeb/tree/master/_libs/jsx). It contains `jsxgraph.css` and `jsxgraph.js`
- Create `head_jsx.html` under `_layout` directory, where `head_jsx.html` is same as

<!-- This result is generated by
```julia-repl
julia> using Markdown
julia> Markdown.htmlesc("""<link rel="stylesheet" href="/libs/jsx/jsxgraph.css">
      <script src="/libs/jsx/jsxgraphcore.js"></script>""")
```
-->
```
&lt;link rel&#61;&quot;stylesheet&quot; href&#61;&quot;/libs/jsx/jsxgraph.css&quot;&gt;
&lt;script src&#61;&quot;/libs/jsx/jsxgraphcore.js&quot;&gt;&lt;/script&gt;
```

\section{Edit `config.md`}

- Create a variable `hasjsx` with default value `false`: in your `config.md` write

  ```
  @def hasjsx = false
  ```

- This procedure is same as [Working with Plotly](https://franklinjl.org/extras/plotly/#work_with_plotly).
- For more details, See [config.md of JSXGraphWeb](https://github.com/tlienart/JSXGraphWeb/blob/master/config.md)

\chapter{Let's get started}

\section{Hello World}

- Everything happens on a Hello world example. Let's add an object on a board with `Hello World`.

`````markdown
```julia
b = board("brd", xlim=[-2,2], ylim=[-2,2])
b ++ point(0, 0, name="Hello World")
```
`````

Is is enough ? Actually NO. We need insert another secret ingredient like:

`````markdown
```julia
println("""~~~&#36;&#40;JSXGraph.standalone&#40;b, preamble&#61;false&#41;&#41;~~~""")
```
`````

Therefore, Franklin users should write code like:

`````markdown
```julia
b = board("brd", xlim=[-2,2], ylim=[-2,2])
b ++ point(0, 0, name="hello")
print("""~~~$(JSXGraph.standalone(b, preamble=false))~~~""") # hide
```
`````

This will give:

```julia:helloworld
b = board("brd", xlim=[-2,2], ylim=[-2,2])
b ++ point(0, 0, name="hello")
print("""~~~$(JSXGraph.standalone(b, preamble=false))~~~""") # hide
```

\textoutput{helloworld}

Congratulations!!!


\chapter{Gallery}

\section{Lissajous curve}

\example{}{}{

```julia:lissajous
b = board("b3", xlim=[-12, 12], ylim=[-10,10])
b ++ (
    slider("a", [[-11,7],[-5,7],[0,3,6]], name="a"),
    slider("b", [[-11,5],[-5,5],[0,2,6]], name="b"),
    slider("A", [[1,7],[7,7],[0,3,6]], name="A"),
    slider("B", [[1,5],[7,5],[0,3,6]], name="B"),
    slider("delta", [[2,-7],[6,-7],[0,0,π]], name="&delta;")
    )
@jsf f1(t) = val(A)*sin(val(a)*t+val(delta))
@jsf f2(t) = val(B)*sin(val(b)*t)
b ++ plot(f1, f2, a=0, b=2π,
          strokecolor="#aa2233", strokewidth=3)
print("""~~~$(JSXGraph.standalone(b, preamble=false))~~~""") # hide
```

\textoutput{lissajous}
}

