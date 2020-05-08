@def title = "Images.jl"
@def reeval = true

\chapter{Visualize Image on Franklin}

- In this page we will show how to display image on your website built with Franklin.jl. Let's load sample image provided by [TestImages.jl](https://github.com/JuliaImages/TestImages.jl)

```julia:init
using TestImages
using ImageShow
```

- To display image, we are going to encode the data to base64. Then we embed the base64 image into Raw HTML. Here is my implementation to achive our purpose:

```julia:showelement
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
```

\section{Examples}

\example{}{cameraman}{
```julia:cameraman
c = testimage("cameraman.tif")
c = testimage('c')
buf = IOBuffer()
encodeimage(buf, c)
# display("text/html", String(take!(buf)))
println("~~~")
println(String(take!(buf)))
println("~~~")
```

\textoutput{cameraman}
}

\example{}{mandrill}{
```julia:mandrill
m = testimage("mandrill.tif")
buf = IOBuffer()
encodeimage(buf, m)
# display("text/html", String(take!(buf)))
println("~~~")
println(String(take!(buf)))
println("~~~")
```

\textoutput{mandrill}
}

\chapter{Different solution}

\example{}{using `image/svg+xml` as MIME}{

- You do not have to use `encodeimage` function. It is simple, but the result will be jaggy.

```julia:cameramanxml
c = testimage("c")
println("~~~")
show(stdout, "image/svg+xml", c)
println("~~~")
```

\textoutput{cameramanxml}
}

\example{}{}{

```julia:mandrillxml
m = testimage("m")
println("~~~")
show(stdout, "image/svg+xml", m)
println("~~~")
```

\textoutput{mandrillxml}
}

