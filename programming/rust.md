@def title = "Rust"

# Hello Rust

- You can compile [Rust](https://www.rust-lang.org/) code and run executable file from Julia with the following code:

```julia
rscode = raw"""
fn main(){
	println!("Hello Rust from Julia runtime");
}
"""

open(`rustc -o sample -`, "w") do f
    print(f, rscode)
end

run(`./sample`)

```

\rustexec{hello}{
fn main(){
    println!("Hello Rust from Julia runtime");
}
}