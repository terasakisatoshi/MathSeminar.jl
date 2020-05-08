# This file was generated, do not modify it. # hide
m = testimage("mandrill.tif")
buf = IOBuffer()
encodeimage(buf, m)
fdimage(m)