# This file was generated, do not modify it. # hide
# hideall
Utils.increment()
thmnum = Utils.getnum()
Utils.record_theorem_number("label1")

name = "prop"

print(
"@@$(name)" *
"~~~<b>$(thmnum):</b>~~~" *
"\\label{label1}" *
raw"""
 主張名\
ぶんすうのけいさんをしたい $\frac{1}{2}$ の計算は次のようにして
$$
\frac{1}{3} 
$$
ときれいにかける.
@@
""")