@def title = "Franklin SandBox"
@def reeval = true

\toc <!-- table of contents -->


```julia:localstate
chapter=1
section=1
subsection=1
```


# This is some

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

```julia:sy
#hideall
println(raw"""
\example{some}{ごまちゃんはかわいい$\frac{1}{3}$}
"""
)
```

\newcommand{\myexample}[2]{
```julia:!#1
#hideall
print(raw"""
**Example**\
!#2
""")
```
\textoutput{!#1}
}

\newcommand{\mytheorem}[2]{
```julia:!#1
#hideall
print(raw"""
@@theorem
#1\
!#2
@@
""")
```
\textoutput{!#1}
}


This is **Example** **_Some_**

\myexample{myex}{
ぶんすうのけいさんをしたい $\frac{1}{4}$ の計算は次のようにして
$$
\frac{1}{5}
$$
ときれいにかける.
}


\mytheorem{goma}{
ぶんすうのけいさんをしたい $\frac{1}{5}$ の計算は次のようにして
$$
\frac{1}{5}
$$
ときれいにかける.
}

I just love **bold text**. \
I just love __bold text__.

```julia:currentstatus
@show chapter
chapter += 1
@show chapter
@show section
@show subsection
```

\show{currentstatus}

<!-- label, title, statement-->
<!-- TODO create julia block using its Julia function-->
\newcommand{\mycounter}[3]{
```julia:!#1
# hideall
v="$(chapter).$(section).$(subsection)"
print(
"@@prop" *
"~~~<b>$(v):</b>~~~" *
"\\label{!#1}" *
raw"""
!#2\
!#3
@@
""")
```
\textoutput{!#1}
}

\mycounter{kyu}{主張名}{
ぶんすうのけいさんをしたい $\frac{1}{2}$ の計算は次のようにして
$$
\frac{1}{3} <>
$$
ときれいにかける<>.
}

\mycounter{label}{}{
ぶんすうのけいさんをしたい $\frac{1}{2}$ の計算は次のようにして
$$
\frac{1}{3} <>
$$
ときれいにかける<>.
}


[link to it](#kyu)

```julia:br
println("<b>aaa</b>")
```

\textoutput{br}

p
~~~
<b>Prop: This text is bold</b><br>
<strong>Prop: This text is strong</strong>
~~~
q

\newcommand{\ref}[1]{
```julia:!#1_ref
#hideall
v="$(chapter).$(section).$(subsection)"
print("[$(v)](#kyu)")
```
\textoutput{!#1_ref}
}

aaa \textoutput{sample} is
\ref{kyu}
