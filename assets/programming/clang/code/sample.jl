# This file was generated, do not modify it. # hide
#hideall
using Markdown

mdC_code = Markdown.htmlesc(raw"""#include <stdio.h>
int main(){
    printf("Hello Goma\n");
    return 0;
}""")
mdC_code = raw"""#include <stdio.h>
int main(){
    printf("Hello Goma\n");
    return 0;
}"""


mdfile = joinpath(dirname(@OUTPUT), "sample.md")
open(mdfile,"w") do f
    print(f, mdC_code)
end

C_code=raw"""
#include <stdio.h>
int main(){
    printf("Hello Goma\n");
    return 0;
}
"""

exefile = tempname()

#=
This trick is taken from

https://discourse.julialang.org/t/how-to-make-a-c-function-compiled-by-myself-available-to-ccall/7972/26
=#

open(`gcc -Wall -O2 -march=native -xc -o $exefile -`, "w") do f
    print(f, C_code)
end

run(`$exefile`)