# This file was generated, do not modify it. # hide
c = testimage("cameraman.tif")
c = testimage('c')
buf = IOBuffer()
encodeimage(buf, c)
fdimage(c)