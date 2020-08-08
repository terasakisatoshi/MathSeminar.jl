@def title = "JSXGraph"
@def hasjsx = false


\toc

\initcounter{}

\chapter{JSXGraph}

- [JSXGraph](https://jsxgraph.uni-bayreuth.de/wp/index.html) is a cross-browser JavaScript library for interactive geometry, function plotting, charting, and data visualization in the web browser.
- Since, JSXGraph.jl is still WIP, it does not support `text` object. If you wish you'll need to write JavaScript by yourself.

~~~
<link rel="stylesheet" href="/libs/jsx/jsxgraph.css">
<script type="text/javascript" src="/libs/jsx/jsxgraphcore.js"></script>
<script id="MathJax-script" async src="https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-mml-chtml.js"></script>
<div id="board" class="jxgbox" style="width:500px; height:500px;"></div>
<script type="text/javascript">
    JXG.Options.text.useMathJax = true;
    var board = JXG.JSXGraph.initBoard(
        "board",
        {
            boundingbox: [-15, 15, 15, -15],
            axis: true
        }
    );
    /* The slider neesd the following input parameters:
    [[x1, y1], [x2, y2], [min, start, max]]
    [x1, y1]: first point of the ruler
    [x2, y2]: last point of the ruler
    min: minimum value of the slider
    start: initial value of the slider
    max: maximum value of the slider
    */
    var a = board.create("slider", [[8, 7], [12, 7], [-3, 0.1, 10]], { name: "a" });
    var b = board.create("slider", [[8, 6], [12, 6], [-1, 1, 5]], { name: "b" });
    var c = board.create("slider", [[8, 5], [12, 5], [-10, -5, 2]], { name: "c" });
    // y = ax^2+bx+c
    var func = board.create(
        "functiongraph",
        [
            function (x) {
                return a.Value() * x * x + b.Value() * x + c.Value();
            }
        ]
    )
    var quadratic = board.create(
        'text',
        [
            2,
            10,
            function () {
                return '\\[f(x) = ax^2+bx+c\\]';
            }
        ],
        { fontSize: 20 }
    );
</script>
~~~

- Here is the code that reproduces the result above:

```html
<link rel="stylesheet" href="/libs/jsx/jsxgraph.css">
<script type="text/javascript" src="/libs/jsx/jsxgraphcore.js"></script>
<script id="MathJax-script" async src="https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-mml-chtml.js"></script>
<div id="board" class="jxgbox" style="width:500px; height:500px;"></div>
<script type="text/javascript">
    JXG.Options.text.useMathJax = true;
    var board = JXG.JSXGraph.initBoard(
        "board",
        {
            boundingbox: [-15, 15, 15, -15],
            axis: true
        }
    );
    /* The slider neesd the following input parameters:
    [[x1, y1], [x2, y2], [min, start, max]]
    [x1, y1]: first point of the ruler
    [x2, y2]: last point of the ruler
    min: minimum value of the slider
    start: initial value of the slider
    max: maximum value of the slider
    */
    var a = board.create("slider", [[8, 7], [12, 7], [-3, 0.1, 10]], { name: "a" });
    var b = board.create("slider", [[8, 6], [12, 6], [-1, 1, 5]], { name: "b" });
    var c = board.create("slider", [[8, 5], [12, 5], [-10, -5, 2]], { name: "c" });
    // y = ax^2+bx+c
    var func = board.create(
        "functiongraph",
        [
            function (x) {
                return a.Value() * x * x + b.Value() * x + c.Value();
            }
        ]
    )
    var quadratic = board.create(
        'text',
        [
            2,
            10,
            function () {
                return '\\[f(x) = ax^2+bx+c\\]';
            }
        ],
        { fontSize: 20 }
    );
</script>
```