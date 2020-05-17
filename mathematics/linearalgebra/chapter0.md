@def title = "Linear Algebras"

\toc

\initcounter{}

\chapter{導入}
- ここでは線形代数学の延長として、行列の特異値分解について述べる. 我々は下記の定理を示すことを目標にする.

\theorem{svddecomp}{}{
$\rank(A) = r>0$ である $m \times n$ 行列 $A\in \Mat_{m,n}(\R)$ に対して次の式を満たす $n$ 次直交行列 $U\in O(n)$, $m$ 次直交行列 $V\in O(m)$, および正の広義単調減少列 $\sigma_1\geq \sigma_2 \geq \dots \geq \sigma_r > 0$ が存在する:

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
- $\R$ は実数のなす集合とする. $x\in\R$ と表記されていたら, "$x$ は実数である"と解釈する.
- $A \coloneqq B$ と書かれていたら $A$ を $B$ で定義するという意味である.
- $\Mat_{m,n}(\R)$ は $m$ 行 $n$ 列の成分が $\R$ の行列の集合をあらわす. $m=n$ であれば $\Mat_{m,n}(\R)$ を $\Mat_{m}(\R)$ と略記することもある. ここでは行列の成分が実数のみの場合を扱う.
- $A\in\Mat_{n}(\R)$ はしばしば $n$ 次正方行列とよばれる.
- 行列 $A\in\Mat_{m,n}(\R)$ に対して $A^\top$ は $A$ の転置行列を表す. 定義により $A^\top\in\Mat_{n,m}(\R)$ である.

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

- $O(n)$ は $U^\top U = U U^\top=I_n$ を満たす $U\in \Mat_n(\R)$ がなす集合とする:
$$
O(n) = \{U\in \Mat_{n}(\R) \mid U^\top U = U U^\top=I_n\}
$$

}

\definition{}{}{
- 二つの $n$ 次元ベクトル $\bm{x}, \bm{y}\in\R^n$ に対する標準内積を $\bra \bm{x},\bm{y}\ket$ を次で定義する:

$$
\bra \bm{x},\bm{y} \ket = \sum_{i=1}^n x_i y_i \quad \mathrm{for} \quad
\bm{x} = \begin{bmatrix}x_1 \\ x_2 \\ \vdots \\ x_n \end{bmatrix}
,\ \bm{y} = \begin{bmatrix}y_1 \\ y_2 \\ \vdots \\ y_n \end{bmatrix}_{\textstyle .}
$$

- またベクトル $\bm{v}$ のノルムは $\norm{\bm{v}}=\sqrt{\bra \bm{v}, \bm{v}\ket}$ で定める.

ここで $I_n$ は単位行列である.

}

<!-- TODO: 直交行列と内積の関係と正規直交基底の話を書く -->

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

\section{二次形式}

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

\subsection{Example}

ここでは $q_A(\bm{x})$ を SymPy.jl を用いて具体的に記述してみよう.

\example{}{$n=2$ の場合}{

```julia:sympyqf2
using SymPy

@vars x1 x2 real=true
@vars a11 a12 real=true
@vars a21 a22 real=true

a21 = a12
A = [
a11 a12
a21 a22
]

x=[
  x1
  x2
]
Utils.fdsympy(x'A*x |> expand)
```

\textoutput{sympyqf2}
}

\example{}{$n=3$ の場合}{
```julia:sympyqf3
using SymPy

@vars x1 x2 x3 real=true
@vars a11 a12 a13 real=true
@vars a21 a22 a23 real=true
@vars a31 a32 a33 real=true

a21 = a12
a31 = a13
a32 = a23

A = [
a11 a12 a13
a21 a22 a23
a31 a32 a33
]

x=[
  x1
  x2
  x3
]
Utils.fdsympy(x'A*x |> expand)
```

\textoutput{sympyqf3}
}

\section{半正定値/正定値行列}

- 半正定値/正定値行列行列の定義をおこなう.

\definition{}{半正定値}{
$n$ 次実対称行列 $A$ が半正定値行列であるとは, 任意の $\bm{x}\in \R^n\setminus \{\bm{0}\}$ に対して $q_A(\bm{x}) \geq 0$ が成り立つことである.
}

- 要するに $q_A$ の値が 0 以上であることを満たすことである.この条件を強くし, $q_A$ の $\bm{0}$ 以外で真に $0$ 以上を満たす場合は正定値という(次の定義を参照).

\definition{positivedefinite}{正定値}{
$n$ 次実対称行列 $A$ が正定値行列であるとは, 任意の $\bm{x}\in \R^n\setminus \{\bf{0}\}$ に対して $q_A(\bm{x}) > 0$ が成り立つことである.
}

- 次の命題は半正定値/正定値行列とその固有値の関係について述べている.

\prop{eigen_value_of_semiposdef}{}{
  $n$ 次半正定値行列 $A$ の固有値は全て 0 以上である.
}

\proof{
  $\lambda$ を $A$ の固有値とし $\bm{v}\neq \bm{0}$ をその対応する固有ベクトルとする. この時
  $$
  0 \leq q_A(\bm{v}) = \bra \bm{v},A\bm{v}\ket
              = \bra \bm{v},\lambda\bm{v}\ket
              = \lambda \norm{\bm{v}}^2 \label{proofsemiprop}
  $$
  という計算から $\lambda$ は 0 以上であることが従う.
}

\prop{}{}{
  $n$ 次正定値行列 $A$ の固有値は全て 0 より真に大きい.
}
\proof{
  \ref{eigen_value_of_semiposdef} の証明と同様である. \eqref{proofsemiprop} と同様の記号のもとで
  $$
  0 < q_A(\bm{v}) = \lambda \norm{\bm{v}}^2
  $$
  が従うことから $\lambda>0$ が従う.
}

- 次の命題に示すように任意の行列から次のように半正定値行列を構成できる. このテクニックは特異値分解の証明に用いられる.

\prop{gram_is_semi_posdef}{}{
  $A\in\Mat_{m,n}(\R)$ に対して $A^\top A\in \Mat_m(\R)$, $AA^\top\in\Mat_n(\R)$ は半正値行列になる.
}
\proof{
  $B \coloneqq A^\top A$ の場合に示す. $\bm{x}\in\R^m$ に対して
  $$
  q_{B}(x) = \bra \bm{x}, A^\top A \bm{x}\ket = \bra A \bm{x}, A\bm{x}\ket = \norm{A\bm{x}} \geq 0
  $$
  となることから $B$ は半正定値であることがわかった.
}

\chapter{特異値分解の導出}

- いよいよ, \ref{svddecomp} の証明に入る. ゼロでない行列 $A\in\Mat_{m,n}(\R)$ に対する特異値分解の証明に入る.
- 命題 \ref{eigen_value_of_semiposdef} 及び \ref{gram_is_semi_posdef} から $A^\top A$ は半正定値行列であるため全ての固有値は 0 以上である. そこで $A^\top A\in\Mat_n(\R)$ の固有値を大きい順に並べ

$$
\lambda_1\geq\lambda_2\geq\dots\geq\lambda_r>\lambda_{r+1}=\dots=\lambda_{n} = 0
$$

と表記する. ここで $r$ は重複度も込めた正の固有値の数とする. $r$ は $\rank(A^\top A)$ と等しい. また $\bm{u}_i$ を $\lambda_i$ の固有値に対応する固有ベクトルとする.

\lemma{AAtop}{}{
  $A\bm{u}_i\ (1\leq i \leq r)$ は $AA^\top$ の固有ベクトルになる.
}
\proof{
 $\bm{v}_i = A\bm{u}_i$ とおく. これが固有ベクトルの定義を満たせば良い:
 $$
 (A A^\top) \bm{v}_i=(A A^\top) (A\bm{u}_i) = A(A^\top A \bm{u}_i) = \lambda_i A \bm{u}_i=\lambda_i \bm{v}_i.
 $$
}

- 同様に $A A^\top\in\Mat_m(\R)$ も半正定値行列である. その固有値を大きい順に並べて

$$
\mu_1 \geq \mu_2 \geq \dots \geq \mu_s > \mu_{s+1} = \dots = \mu_m = 0
$$

と表記する. $\bm{v}_i$ を $\mu_i$ に対応する固有ベクトルとする. $s$ は $A A^\top$ の固有値で重複度も込めて 0 よりも大きい物の個数とする. 補題

 \ref{AAtop} によって $s\geq r$ が従う. 同様に $A^\top \bm{v}_i\ (1\leq i\leq j)$ は $A^\top A$ の固有ベクトルとなることが示されるので $s\leq r$ となる. つまり $s=r$ が従う.

\prop{}{}{
- $A^\top A$ と $A A^\top$ は共通した正の固有値を持つ.
- $\rank(A^\top A) = \rank(A A^\top)$
- $\bm{v}_i = \frac{1}{2} A \bm{u}_i\ (1\leq i \leq r)$ は正規直交系をなす.
}


\lemma{}{}{
$\Mat_{m,n}(\R)$ に対して次が成り立つ:
$$
\Ker(A^\top A) = \Ker(A).
$$
}
