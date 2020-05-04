# This file was generated, do not modify it. # hide
b = board("b3", xlim=[-12, 12], ylim=[-10,10])
b ++ (
    slider("a", [[-11,7],[-5,7],[0,3,6]], name="a"),
    slider("b", [[-11,5],[-5,5],[0,2,6]], name="b"),
    slider("A", [[1,7],[7,7],[0,3,6]], name="A"),
    slider("B", [[1,5],[7,5],[0,3,6]], name="B"),
    slider("delta", [[2,-7],[6,-7],[0,0,π]], name="&delta;")
    )
@jsf f1(t) = val(A)*sin(val(a)*t+val(delta))
@jsf f2(t) = val(B)*sin(val(b)*t)
b ++ plot(f1, f2, a=0, b=2π,
          strokecolor="#aa2233", strokewidth=3)
print("""~~~$(JSXGraph.standalone(b, preamble=false))~~~""") # hide