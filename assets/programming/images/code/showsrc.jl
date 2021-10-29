# This file was generated, do not modify it. # hide
#hideall
src = raw"""
# Reference:
# https://github.com/JuliaImages/ImageShow.jl/blob/master/src/showmime.jl#L115

using Base64

function encodeimage(io::IOBuffer, img)
    io2=IOBuffer()
    b64pipe=Base64EncodePipe(io2)
    write(io,"<img style='display:inline' src=\"data:image/png;base64,")
    show(b64pipe, MIME"image/png"(), img) # will be valid if we load ImageShow.jl
    write(io, read(seekstart(io2)))
    write(io,"\">")
end

function fdimage(img)
    io = IOBuffer()
    encodeimage(io, img)
    println("~~~")
    println(String(take!(buf)))
    println("~~~")
end
"""

using Markdown
println(Markdown.htmlesc(src))