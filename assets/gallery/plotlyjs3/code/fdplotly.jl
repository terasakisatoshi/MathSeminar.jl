# This file was generated, do not modify it. # hide
using Random
function fdplotly(p::Plots.Plot;
    id="fdp" * Random.randstring('a':'z', 3),
    style = "width:600px;height:350px")::Nothing
    b = Plots.js_body(p, id)
    println("""~~~<div id="$id" style="$style"></div> <script> $b </script>~~~""") # hide
    return nothing
end