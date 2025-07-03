restart

-- load package and setup equations
needsPackage "MonodromySolver"
parMatrix = gateMatrix{toList vars(q_(0,0)..q_(8,5),c_(0,0)..c_(4,3),ca_(0,0)..ca_(5,5),ca_36)}
varMatrix = gateMatrix{toList vars(x_0..x_4,y_0..y_4,z_0..z_4,a_(0,0)..a_(5,5))}
ptsP5 = apply(9, i -> matrix{apply(6, j -> q_(i,j))})
I = gateMatrix {{1,0,0},{0,1,0},{0,0,1}}
v2 = (x,y,z, A) -> matrix{{x^2,y^2,z^2,x*y,x*z,y*z}} * A
A = matrix apply(6, i -> apply(6, j -> a_(i,j)))
vPtsP2 = apply(5, i -> v2(x_i,y_i,z_i, A))
vPtsP2 = vPtsP2 | apply({(1,0,0,A), (0,1,0,A), (0,0,1,A), (1,1,1,A)}, seq -> v2(seq))
eqs = flatten apply(vPtsP2, ptsP5, (x, y) -> (
	M := x||y;
	apply(subsets(6, 2), S -> det(M_S))
	    )
	);
chartsP2 = apply(5, i -> c_(i,0) * x_i + c_(i,1) * y_i + c_(i,2) * z_i +  c_(i, 3))
charts = chartsP2 | {sum((0,0)..(5,5), (i,j) -> A_(i,j) * ca_(i,j)) + ca_36}
G = gateSystem(parMatrix, varMatrix, transpose gateMatrix{eqs | charts})

-- fabricate initial problem-solution pair
fabA = random(CC^6, CC^6)
fabPtsP2 = apply(5, i -> random(CC^1, CC^3)) | {matrix{{1,0,0}}, matrix{{0,1,0}}, matrix{{0,0,1}}, matrix{{1,1,1}}}
fabPtsP5 = apply(fabPtsP2, p -> v2(p_(0,0),p_(0,1),p_(0,2),fabA))
fabParam = fold(fabPtsP5, (a,b) -> a|b)
fabSol = matrix{flatten entries transpose fold(drop(fabPtsP2, -4), (a,b) -> a||b)} | matrix{flatten entries fabA}
fabChartsP2 = apply(drop(fabPtsP2, -4), x -> random(CC^1, CC^3)*transpose numericalKernel(x|matrix{{1}}))
fabChartA = random(CC^1, CC^36) *transpose numericalKernel matrix{flatten entries fabA | {1}}
fabParam = fold(fabPtsP5 | fabChartsP2 | {fabChartA}, (a,b) -> a|b)

-- sanity checks on problem-solution pair
norm evaluate(G, fabParam, fabSol)
numericalRank evaluateJacobian(G, fabParam, fabSol)

-- obtain local equations and run monodromy
(p0, x0) = (point fabParam, point fabSol)
Gs = squareUp(p0, x0, G)
(V, npaths) = monodromySolve(Gs, point fabParam, {point fabSol})
-- output
V.BasePoint -- parameter values 
netList points V.PartialSols -- solutions at V.BasePoint
netList monodromyGroup(V.Graph) -- permutations in one-line notation

-- how many veroneses through 4 "random" real points?
for i from 1 to 10 list (
    print(toString(i) | "-th iteration");
    p0 = matrix V.BasePoint;
    p1 = random(RR^1, RR^(numParameters G));
    H = specialize(parametricSegmentHomotopy Gs, transpose(p0|p1));
    nReal = # realPoints trackHomotopy(H, points V.PartialSols);
    print(toString(nReal) | " real solutions out of 4 complex");
    )
tally oo
