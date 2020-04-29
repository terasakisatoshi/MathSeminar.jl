@def title = "Introduction To Franklin"
@def reeval = true
@def chapter = 0
@def section = 0
@def subsection = 0




# Franklin sand box

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
