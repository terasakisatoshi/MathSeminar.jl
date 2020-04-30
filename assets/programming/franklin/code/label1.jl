# This file was generated, do not modify it. # hide
# hideall
Utils.increment()
thmnum = Utils.getnum()
Utils.labelthm("label1")

print(
"@@prop" *
"~~~<b>$(thmnum):</b>~~~" *
"\\label{label1}" *
raw"""
主張名\
ぶんすうのけいさんをしたい $\frac{1}{2}$ の計算は次のようにして
$$
\frac{1}{3} <>
$$
ときれいにかける<>.
@@
""")