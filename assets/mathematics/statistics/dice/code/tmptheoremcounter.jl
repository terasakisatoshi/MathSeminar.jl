# This file was generated, do not modify it. # hide
# hideall
Utils.increment()
Utils.record_theorem_number("samplemeanvar")
thmnum = Utils.getnum()
label = Utils.generate_label("samplemeanvar")
name = Utils.generate_name("")

theorem_name = "prop"

print(
"\\label{samplemeanvar}" *
"@@$(theorem_name)" *
"~~~<b>$(thmnum):</b>~~~ $(name)~~~</br>~~~" *
"\n" *
raw"""
- 平均が $\mu$, 分散が $\sigma^2$ である分布から独立に抽出したサンプルの $\{X_i\}_{i=1}^n$ から定まる標本平均 $\bar{X}$ の平均 $E[\bar{X}]$, 分散 $V(\bar{X})$は各々次で与えられる:
$$
    \begin{aligned} E[\bar{X}] = \mu, && V[\bar{X}] = \frac{\sigma^2}{n}. \end{aligned}
$$@@
"""
)