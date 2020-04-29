# This file was generated, do not modify it. # hide
# hideall
v="$(chapter).$(section).$(subsection)"
print(
"@@prop" *
"~~~<b>$(v):</b>~~~" *
"\\label{label}" *
raw"""
\
ぶんすうのけいさんをしたい $\frac{1}{2}$ の計算は次のようにして
$$
\frac{1}{3} <>
$$
ときれいにかける<>.
@@
""")