@def title = "Sand box"

@def hasmath = true
@def hascode = true

\toc <!-- table of contents -->


```julia:mystate
Utils.init() # hide
```

# Franklin Sand Box

\label{something}

{{chapter}}
@def chapter=1
{{chapter}}

{{fd_rpath}}
{{fd_ctime}}
{{fd_mtime}}

This has a footnote[^1]

[^1]: footnote is here

inline links: [plain link](https:://www.wikipedia.org)

reference links: ["reference" link][reflink] and ["reference" link][]

[reflink]: https://www.wikipedia.org
["reference" link]: https://www.wikipedia.org

In the text you may refer to \citep{noether15, bezanson17} while in a bibliography section you would have

* \biblabel{noether15}{Noether (1915)} **Noether**, Korper und Systeme rationaler Funktionen, 1915.
* \biblabel{bezanson17}{Bezanson et al. (2017)} **Bezanson**, **Edelman**, **Karpinski** and **Shah**, [Julia: a fresh approach to numerical computing](https://julialang.org/publications/julia-fresh-approach-BEKS.pdf), SIAM review 2017.

Some equation:

$$\exp(i\pi) + 1 = 0 \label{a cool equation}$$

and you can refer to it in the text: equation \eqref{a cool equation}.

[link to it](#something)

In the text you may refer to \citep{noether15} while in a bibliography section you would have

$$\exp(i\pi) + 1 = 0 \label{a cool equation}$$


```julia:some
using Franklin
@show Franklin.PAGE_EQREFS[Franklin.PAGE_EQREFS_COUNTER]
```

\output{some}


This is **Example** **_Some_**


I just love **bold text**. \
I just love __bold text__.

\mycounter{label1}{主張名}{
ぶんすうのけいさんをしたい $\frac{1}{2}$ の計算は次のようにして
$$
\frac{1}{3} <>
$$
ときれいにかける<>.
}

\mycounter{label2}{}{
ぶんすうのけいさんをしたい $\frac{1}{2}$ の計算は次のようにして
$$
\frac{1}{3} <>
$$
ときれいにかける<>.
}

\setlevel{section}

\mycounter{label3}{}{
ぶんすうのけいさんをしたい $\frac{1}{2}$ の計算は次のようにして
$$
\frac{1}{3} <>
$$
ときれいにかける<>.
}

\ref{label1} \

\ref{label2} \

\ref{label3}

```julia:br
println("<b>aaa</b>")
```

\textoutput{br}

```julia:mydebug
@show Utils.state
```

\show{mydebug}

p
~~~
<b>Prop: This text is bold</b><br>
<strong>Prop: This text is strong</strong>
~~~
q


[here](#something)

```julia:showπ
# This block causes an error as follow
# // `\show{showπ}`: could not find the relevant output file. //
@show π
```




```julia:showπ
@show π
```

\show{showπ}
