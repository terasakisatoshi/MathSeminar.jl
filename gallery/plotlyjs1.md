@def title = "PlotlyJS Example1"
@def hasmath = true
@def hascode = true
@def hasplotly = true

\csschapter{Offline-generated plot}

Assuming you already have the Plotly code for some plot, displaying  the  result on a page with Franklin is now pretty straightforward.
Start by adding

```
@def hasplotly = true
```

so that the JS library  will be  loaded then somewhere appropriate add:

```html
~~~
<div id="tester" style="width:600px;height:350px;"></div>

<script>
    TESTER = document.getElementById('tester');
    Plotly.plot( TESTER, [{
    x: [1, 2, 3, 4, 5],
    y: [1, 2, 4, 8, 16] }], {
    margin: { t: 0 } } );
</script>
~~~
```

This will give:

~~~
<div id="tester" style="width:600px;height:350px;"></div>

<script>
    TESTER = document.getElementById('tester');
    Plotly.plot( TESTER, [{
    x: [1, 2, 3, 4, 5],
    y: [1, 2, 4, 8, 16] }], {
    margin: { t: 0 } } );
</script>
~~~


```julia:plotlyexample1
using PlotlyJS
z =  [10     10.625  12.5  15.625  20
     5.625  6.25    8.125 11.25   15.625
     2.5    3.125   5.    8.125   12.5
     0.625  1.25    3.125 6.25    10.625
     0      0.625   2.5   5.625   10]

data   = contour(; z=z)
layout = Layout(; title="Basic Contour Plot")
plt    = plot(data, layout)

fdplotly(json(plt)) # hide
```
\textoutput{plotlyexample1}
