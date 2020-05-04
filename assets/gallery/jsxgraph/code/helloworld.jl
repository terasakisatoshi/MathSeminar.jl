# This file was generated, do not modify it. # hide
b = board("brd", xlim=[-2,2], ylim=[-2,2])
b ++ point(0, 0, name="hello")
print("""~~~$(JSXGraph.standalone(b, preamble=false))~~~""") # hide