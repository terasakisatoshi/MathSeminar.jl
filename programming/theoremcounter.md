@def title = "Theorem Counter"
@def hasmath = true
@def hascode = true
@def reeval = true

\chapter{Theorem Counter}

- I would like to implement counter e.g. Numbered theorems, definitions, corollaries and lemmas like [Overleaf sample](https://www.overleaf.com/learn/latex/theorems_and_proofs)

```julia:initialize
Utils.init() #hide
```

```julia:showπ
@show π
```

\show{showπ}

```julia:定理_3_2_1
@show 32
```

\show{定理_3_2_1}




```plaintext
\begin{theorem}
Let $f$ be a function whose derivative exists in every point, then $f$ is
a continuous function.
\end{theorem}
```


\prop{label1}{主張名}{
ぶんすうのけいさんをしたい $\frac{1}{2}$ の計算は次のようにして
$$
\frac{1}{2} <>
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
\frac{1}{4} <>
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
\frac{1}{5} <>
$$
ときれいにかける<>.
}

\lemma{}{}{
- 名無しのゴンベ
- 名無しの権兵衛
}

```julia:debug
@show Utils.state
```

\show{debug}
