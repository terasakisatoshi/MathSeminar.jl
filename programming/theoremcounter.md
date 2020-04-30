@def title = "Theorem Counter"
@def hasmath = true
@def hascode = true
@def reeval = true


\chapter{Theorem Counter}

- I would like to implement counter e.g. Numbered theorems, definitions, corollaries and lemmas like [Overleaf sample](https://www.overleaf.com/learn/latex/theorems_and_proofs)

```plaintext
\begin{theorem}
Let $f$ be a function whose derivative exists in every point, then $f$ is
a continuous function.
\end{theorem}
```


```julia:initialize
Utils.init() # hide
```

\prop{label1}{主張名}{
ぶんすうのけいさんをしたい $\frac{1}{2}$ の計算は次のようにして
$$
\frac{1}{3} <>
$$
ときれいにかける<>.
}

\theorem{label2}{}{
ぶんすうのけいさんをしたい $\frac{1}{2}$ の計算は次のようにして
$$
\frac{1}{3} <>
$$
ときれいにかける<>.
}


\section{Section}

\lemma{label3}{}{
ぶんすうのけいさんをしたい $\frac{1}{2}$ の計算は次のようにして
$$
\frac{1}{3} <>
$$
ときれいにかける<>.
}

\ref{label1} \

\ref{label2} \

\ref{label3}

\subsection{SubSection}

\lemma{label4}{}{
ぶんすうのけいさんをしたい $\frac{1}{2}$ の計算は次のようにして
$$
\frac{1}{3} <>
$$
ときれいにかける<>.
}

@@lemma

@@