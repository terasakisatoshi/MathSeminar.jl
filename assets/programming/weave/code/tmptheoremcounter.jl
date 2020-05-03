# This file was generated, do not modify it. # hide
# hideall
Utils.increment()
Utils.record_theorem_number("label1")
thmnum = Utils.getnum()
label = Utils.generate_label("label1")
name = Utils.generate_name("主張名")

theorem_name = "prop"

print(
"\\label{label1}" *
"@@$(theorem_name)" *
"~~~<b>$(thmnum):</b>~~~ $(name)~~~</br>~~~" *
"\n" *
raw"""
ぶんすうのけいさんをしたい $\frac{1}{2}$ の計算は次のようにして
$$
\frac{1}{3} 
$$
ときれいにかける.@@
"""
)