# This file was generated, do not modify it. # hide
# hideall
Utils.increment()
Utils.record_theorem_number("")
thmnum = Utils.getnum()
label = Utils.generate_label("")
name = Utils.generate_name("")

theorem_name = "lemma"

print(
"\\label{}" *
"@@$(theorem_name)" *
"~~~<b>$(thmnum)</b>~~~ $(name)~~~</br>~~~" *
"\n" *
raw"""
- 名無しのゴンベ
- 名無しの権兵衛@@
"""
)