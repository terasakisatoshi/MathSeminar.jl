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
@def ignore = ["remark/src/", ".statements/"]

<!-- Thank you Lucas-->
<!-- https://github.com/tlienart/Franklin.jl/blob/e0fe6b99bef5a4a054d793a410e3e83fb9876250/test/utils/misc.jl#L129-L190 -->
@def date_format = "Y年ud日 E"
@def date_months = ["1月", "2月", "3月", "4月", "5月", "6月",
                    "7月", "8月", "9月", "10月", "11月", "12月"]
@def date_days = ["月曜日","火曜日","水曜日","木曜日",
                    "金曜日","土曜日","日曜日"]

<!-- ---------------------------------------------------
Add here global latex commands to use throughout your
pages. It can be math commands but does not need to be.
For instance:
* \newcommand{\phrase}{This is a long phrase to copy.}
----------------------------------------------------- -->
\newcommand{\R}{\mathbb R}
\newcommand{\Q}{\mathbb Q}
\newcommand{\Z}{\mathbb Z}
\newcommand{\N}{\mathbb N}

<!-- Put a box around something and pass some css styling to the box
(useful for images for instance) e.g. :
\style{width:80%;}{![](path/to/img.png)} -->
\newcommand{\style}[2]{~~~<div style="!#1;margin-left:auto;margin-right:auto;">~~~!#2~~~</div>~~~}

<!-- define document counter enumerated by _css/theorem.css -->
\newcommand{\csschapter}[1]{# #1 @@reset@@}
\newcommand{\csssection}[1]{## #1 @@reset@@}
\newcommand{\csssubsection}[1]{### #1}

<!-- define document counter enumerated by utils.jl -->

\newcommand{\chapter}[1]{
# #1
\setlevel{chapter}
\increment{}
\setlevel{subsection}
\resetcount{}
@@reset@@
}
\newcommand{\section}[1]{
## #1

\setlevel{section}
\increment{}
\setlevel{subsection}
\resetcount{}
@@reset@@
}
\newcommand{\subsection}[1]{### #1}

<!-- numbered definition/prop/lemma/theorem/example/remark enumerated by CSS -->

\newcommand{\csstheoremcounter}[3]{
@@!#1 !#2 \\
!#3
@@
}

\newcommand{\cssproof}[1]{
@@cssproof
!#1
@@
}

\newcommand{\cssdefinition}[2]{\csstheoremcounter{cssdefinition}{#1}{#2}}
\newcommand{\cssprop}[2]{\csstheoremcounter{cssprop}{#1}{#2}}
\newcommand{\csslemma}[2]{\csstheoremcounter{csslemma}{#1}{#2}}
\newcommand{\csstheorem}[2]{\csstheoremcounter{csstheorem}{#1}{#2}}
\newcommand{\cssexample}[2]{\csstheoremcounter{cssexample}{#1}{#2}}
\newcommand{\cssremark}[2]{\csstheoremcounter{cssremark}{#1}{#2}}

<!-- ame, label, title, statement-->
\newcommand{\theoremcounter}[4]{
```julia:!#2
# hideall
Utils.increment()
thmnum = Utils.getnum()
Utils.record_theorem_number("!#2")

name = "!#1"

print(
"@@$(name)" *
"~~~<b>$(thmnum):</b>~~~" *
"\\label{!#2}" *
raw"""
#3\
!#4
@@
""")
```
\textoutput{!#2}
}

\newcommand{\definition}[3]{\theoremcounter{definition}{#1}{#2}{#3}}
\newcommand{\lemma}[3]{\theoremcounter{lemma}{#1}{#2}{#3}}
\newcommand{\prop}[3]{\theoremcounter{prop}{#1}{#2}{#3}}
\newcommand{\theorem}[3]{\theoremcounter{theorem}{#1}{#2}{#3}}
\newcommand{\example}[3]{\theoremcounter{example}{#1}{#2}{#3}}
\newcommand{\remark}[3]{\theoremcounter{remark}{#1}{#2}{#3}}
\newcommand{\proof}[1]{
@@proof
!#1
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

mdC_code = Markdown.htmlesc(raw"""!#2""")

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
