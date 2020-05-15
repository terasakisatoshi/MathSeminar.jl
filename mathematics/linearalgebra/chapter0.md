@def title = "Linear Algebras"

\initcounter{}

\chapter{特異値分解の話}	
- ここでは線形代数学の延長として、行列の特異値分解について述べる。我々は下記の定理を示すことを目標にする。

\theorem{}{}{
$\mathrm{rank}(A) = r$ である $m \times n$ 行列 $A\in \mathrm{Mat}_{m,n}(\mathbb{R})$ に対して次の式を満たす $n$ 次直交行列 $U\in O(n)$, $m$ 次直交行列 $V\in O(m)$, および正の広義単調減少列 $\sigma_1\geq \sigma_2 \geq \dots \geq \sigma_r > 0$ が存在する:

$$
A = U \Sigma V^{\top}, \label{svd}
$$

<!-- TODO use better expression big matrix \Sigma -->

$$
\Sigma = \begin{bmatrix}
\sigma_1 & 0          &  \dots   & \dots    & \dots &	\dots & 0 \\
0        & \sigma_2   &  0       & \dots    & \dots &   \dots & 0 \\
\vdots   &  0         & \ddots   & 0        & \dots &   \dots & \vdots \\
0        &  \dots     & 0        & \sigma_r & 0     &   \dots & 0 \\
0        &  0         & 0        & 0        & 0     & \dots   & 0 \\
\vdots   &  \vdots    & \vdots   & \vdots   & \vdots      & \ddots  & 0 \\
0        &  0         & 0        & 0        & 0     & \dots   & 0\\
\end{bmatrix}_{\textstyle .}
$$

$\Sigma$ は $1\leq i \leq r$ のとき $(i,i)$ 成分が $\sigma_i$ でありそれ以外の成分はすべて 0 である行列である. \eqref{svd} の右辺を $A$ の特異値分解とよび, $\sigma_1,\sigma_2,\dots,\sigma_r$ を特異値とよぶ.
}

- 特異値分解は機械学習や信号処理の話題で頻出する概念である, にもかかわらず多くの書籍では証明抜きで紹介されたり, 証明の議論に曖昧さが残ったりするものが多い。ここでは実対称行列が対角化可能という事実から出発しなるべく丁寧に導出することにする.


