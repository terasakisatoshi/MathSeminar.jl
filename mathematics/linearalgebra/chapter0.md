@def title = "Linear Algebras"

\initcounter{}

\chapter{導入}
- ここでは線形代数学の延長として、行列の特異値分解について述べる. 我々は下記の定理を示すことを目標にする.

\theorem{}{}{
$\mathrm{rank}(A) = r$ である $m \times n$ 行列 $A\in \Mat_{m,n}(\R)$ に対して次の式を満たす $n$ 次直交行列 $U\in O(n)$, $m$ 次直交行列 $V\in O(m)$, および正の広義単調減少列 $\sigma_1\geq \sigma_2 \geq \dots \geq \sigma_r > 0$ が存在する:

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
\end{bmatrix}_{\textstyle .} \label{Sigma}
$$

ここで, \eqref{Sigma} における $\Sigma$ は $1\leq i \leq r$ のとき $(i,i)$ 成分が $\sigma_i$ でありそれ以外の成分はすべて 0 である行列である. \eqref{svd} の右辺を $A$ の特異値分解とよび, $\sigma_1,\sigma_2,\dots,\sigma_r$ を特異値とよぶ.
}

- 特異値分解は機械学習や信号処理の話題で頻出する概念である, にもかかわらず多くの書籍では証明抜きで紹介されたり, 証明の議論に曖昧さが残ったりするものが多い. ここでは実対称行列が対角化可能という事実から出発しなるべく丁寧に導出することにする.

\section{記号の準備}

- 以下ではいくつか記号の定義をする.

\definition{}{記号の準備}{

- $\Mat_{m,n}(\R)$ は $m$ 行 $n$ 列の成分が $\R$ の行列の集合をあらわす. $m=n$ であれば $\Mat_{m,n}(\R)$ を $\Mat_{m}(\R)$ と略記することもある. ここでは行列の成分が実数のみの場合を扱う.
- $A\in\Mat_{n}(\R)$ はしばしば $n$ 次正方行列とよばれる.
- 行列 $A\in\Mat_{m,n}(\R)$ に対して $A^\top$ は $A$ の転置行列を表す. 定義により $A^\top\in\Mat_{n,m}(\R)$ である.
- $O(n)$ は $U^\top U = U U^\top=I_n$ を満たす $U\in \Mat_n(\R)$ がなす集合とする:
- 二つの $n$ 次元ベクトル $x, y\in\R^n$ に対する標準内積を $\bra \bm{x},\bm{y}\ket$ を次で定義する:

$$
\bra \bm{x},\bm{y} \ket = \sum_{i=1}^n x_i y_i \quad \mathrm{for} \quad
x = \begin{bmatrix}x_1 \\ x_2 \\ \vdots \\ x_n \end{bmatrix}
,\ y = \begin{bmatrix}y_1 \\ y_2 \\ \vdots \\ y_n \end{bmatrix}
$$

$$
O(n) = \{U\in \Mat_{n}(\R) \mid U^\top U = U U^\top=I_n\}
$$

ここで $I_n$ は単位行列である.

- $\lambda_1,\dots,\lambda_n\in \R$ に対して , $\diag(\lambda_1, \lambda_2,\dots,\lambda_n)$ を $(i,i)$ - 成分が $\lambda_i$ である対角行列とする. すなわち,

$$
\diag(\lambda_1, \lambda_2,\dots,\lambda_n)
=
\begin{bmatrix}
\lambda_1 &           &        &\\
          & \lambda_2 &        &\\
          &           & \ddots & \\
          &           &        & \lambda_n\\
\end{bmatrix}
$$

と定義する.
}

\chapter{証明のための準備}

- 特異値分解の証明を理解するための必要な数学的概念を導入する.

\section{実対称行列}

\definition{}{実対称行列}{$n$ 次正方行列 $A$, すなわち, $A\in\Mat_{n}(\R)$ に対して $A^T = A$ を満たすものを対称行列と呼ぶ. 特に成分が実数であることを強調する場合は実対称行列と呼ぶ.}

- ここでは通常の線形代数学の講義で取り扱う対称行列が対角可能であることを認める.

\prop{}{実対称行列の対角可能性}{
$n$ 次対称行列 $A$ は適当な直交行列により対角化できる. すなわち, 次の条件を満たす $U\in O(n)$ 及び $\lambda_1,\lambda_2,\dots,\lambda_n\in\R$ が存在する:

$$
A = U \diag(\lambda_1,\lambda_2,\dots,\lambda_n) U^\top.
$$

さらに $\lambda_i\ (1\leq i \leq n)$ は $A$ の固有値になる.
}

\section{正定値行列}

\definition{}{二次形式}{
- $A$ を $n$ 次実対称行列とする. $\bm{x}\in\R^n$ に対して $q_A(\bm{x}) = \bm{x}^\top A \bm{x}$ を $A$ が定める二次形式 (quadratic form) と呼ぶ. $\bm{x}=\left[x_1,\dots,x_n\right]^\top$, $A=[a_{ij}]_{i,j=1}^{n}$ と成分表示した場合に, $q_A(\bm{x})$ は次のようになる:

$$
q_A(\bm{x}) = \sum_{i,j=1}^n a_{ij}x_ix_j = \sum_{i=1}^n a_{ii}x_i^2 + 2\sum_{1\leq i < j\leq n} a_{ij}x_i x_j.
$$

- また, 二次形式は次のように内積を用いて表すことができることに注意する:

$$
q_A(\bm{x}) = \bm{x}^\top A \bm{x} = \bra \bm{x},A\bm{x} \ket.
$$
}

\definition{}{正定値}{
$\bm{x}$
}
