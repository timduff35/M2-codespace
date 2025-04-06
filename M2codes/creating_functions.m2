sq = i -> i^2

 tm = (i,j) -> i*j

 sincos = sin @@ cos

 comp = (f,g) -> x -> f(g x)

 sincos = comp(sin,cos)

 sincos 2.2