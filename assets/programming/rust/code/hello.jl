# This file was generated, do not modify it. # hide
#hideall
using Markdown

mdrs_code = Markdown.htmlesc(raw"""fn main(){
    println!("Hello Rust from Julia runtime");
}""")
mdrs_code = raw"""fn main(){
    println!("Hello Rust from Julia runtime");
}"""



mdfile = joinpath(dirname(@OUTPUT), "hello.md")
open(mdfile,"w") do f
    print(f, mdrs_code)
end

rs_code=raw"""
fn main(){
    println!("Hello Rust from Julia runtime");
}
"""

exefile = tempname()

#=
This trick is taken from

https://discourse.julialang.org/t/how-to-make-a-c-function-compiled-by-myself-available-to-ccall/7972/26
=#

open(`rustc -o $exefile -`, "w") do f
    print(f, rs_code)
end

run(`$exefile`)