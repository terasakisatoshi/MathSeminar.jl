<!-- ---------------------------------------------------
Add here global page variables to use throughout your
website.
The website_* must be defined for the RSS to work
----------------------------------------------------- -->
@def website_title = "terasakisatoshi's math-blog"
@def website_descr = "terasakisatoshi's math-blog"
@def website_url   = "https://terasakisatoshi.github.io/MathWebiner.jl"
@def hasplotly = false
@def author = "SatoshiTerasaki"
@def prepath = "MathSeminar.jl"
@def ignore = ["remark/src/"]
<!-- ---------------------------------------------------
Add here global latex commands to use throughout your
pages. It can be math commands but does not need to be.
For instance:
* \newcommand{\phrase}{This is a long phrase to copy.}
----------------------------------------------------- -->
\newcommand{\R}{\mathbb R}
\newcommand{\Q}{\mathbb Q}

<!-- Put a box around something and pass some css styling to the box
(useful for images for instance) e.g. :
\style{width:80%;}{![](path/to/img.png)} -->
\newcommand{\style}[2]{~~~<div style="!#1;margin-left:auto;margin-right:auto;">~~~!#2~~~</div>~~~}

\newcommand{\chapter}[1]{
  # #1
  @@reset@@
}

\newcommand{\section}[1]{
  ## #1
  @@reset@@
}

\newcommand{\subsection}[1]{
  ### #1
}

\newcommand{\space}{$\ $}
\newcommand{\definition}[2]{
@@definition \space#1\
#2
@@
}

\newcommand{\prop}[2]{
@@prop \space#1\
#2
@@
}


\newcommand{\lemma}[2]{
@@lemma \space#1\
#2
@@
}

\newcommand{\theorem}[2]{
@@theorem \space#1\
#2
@@
}

\newcommand{\proof}[1]{
@@proof \\
#1
@@
\\
}

\newcommand{\example}[2]{
@@example \space#1\
#2
@@
}

\newcommand{\remark}[2]{
@@remark \space#1\
#2
@@
}

\newcommand{\pycode}[2]{
```julia:!#1
#hideall
using PyCall
lines = replace("""!#2""", r"(^|\n)([^\n]+)\n?$" => s"\1res = \2")
py"""
$$lines
"""
println(py"res")
```
```python
#2
```
\codeoutput{!#1}
}


<!-- display C code with syntax highlight-->
\newcommand{\Ccode}[2]{
```julia:!#1
#hideall
using Markdown

mdC_code = raw"""!#2"""
mdfile = joinpath(dirname(@OUTPUT), "!#1.md")
open(mdfile,"w") do f
    print(f, mdC_code)
end

C_code=raw"""
!#2
"""

exefile = tempname()

#=
This trick is taken from

https://discourse.julialang.org/t/how-to-make-a-c-function-compiled-by-myself-available-to-ccall/7972/26
=#

open(`gcc -Wall -O2 -march=native -xc -o $exefile -`, "w") do f
    print(f, C_code)
end

run(`$exefile`)
```

\input{c}{!#1.md}
}

<!-- run C code and display code and its result -->
\newcommand{\Cexec}[2]{
\Ccode{!#1}{!#2}

\codeoutput{!#1}

}
