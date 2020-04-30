# This file was generated, do not modify it. # hide
# hideall
Utils.increment()
thmnum = Utils.getnum()
Utils.record_theorem_number("label3")

name = "lemma"

print(
"@@$(name)" *
"~~~<b>$(thmnum):</b>~~~" *
"\\label{label3}" *
raw"""
 \
ぶんすうのけいさんをしたい $\frac{1}{2}$ の計算は次のようにして
$$
\frac{1}{3} <>
$$
ときれいにかける<>.
@@
""")