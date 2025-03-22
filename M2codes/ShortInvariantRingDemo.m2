restart
needsPackage "InvariantRing"

viewHelp "InvariantRing"

R=QQ[x,y]

-- Let's look at a finite (matrix) group action
-- It is enough to consider the action of a generator
M = {matrix {{1,0},{0,-1}}}
A1 = finiteAction(M, R)
invariants(A1)

L = {matrix {{0,-1},{1,0}}}
A2 = finiteAction(L, R)
invariants(A2)

-- We can look at invariants of any specific degree
invariants(A2,2)
invariants(A2,3)
invariants(A2,4)

isAbelian(A2)

-- We have a shorthand for the invariant ring
S = R^A1
gens S

-- Diagonal group action
d={4}
W = matrix{{1,3}}
A3 = diagonalAction(W,d,R)
invariants(A2)


-- C3xC3 acting on polynomial ring in two vars
restart
needsPackage "InvariantRing"
R = QQ[x_1..x_3]
W = matrix{{1,0,1},{0,1,1}}
L = {3,3}
T = diagonalAction(W,L,R)
S = R^T
invariantRing T
-- resolution of Hilbert ideal
I = definingIdeal S 
Q = ring I
F = res I
-- Hilbert series of ring of invariants
hilbertSeries S


restart
needsPackage "InvariantRing"
R = QQ[x_1..x_4]
L = apply({[2,1,3,4],[2,3,4,1]},permutationMatrix)
S4 = finiteAction(L,R)
elapsedTime invariants S4
elapsedTime invariants(S4,Strategy=>"LinearAlgebra")





