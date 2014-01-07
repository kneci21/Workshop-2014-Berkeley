needsPackage "GraphicalModels"

--G = mixedGraph(digraph {{1,{2,3}},{2,{3}},{3,{4}}},bigraph {{1,2},{2,4}});
G = mixedGraph(digraph {{1, {2}}, {2, {3}}}, bigraph {{1, 2}});
-- number of vertices in G
d = 3;
-- list whose rows are the sampels
--U = {matrix{{1,2,1,-1}}, matrix{{2,1,3,0}}, matrix{{-1, 0, 1, 1}}};
U = {matrix{{1, 2, 0}}, matrix{{-1, 0, 1}}, matrix{{3, 1, 2}}, matrix{{-1, -2, 1}}};
R = gaussianRing G;
I = gaussianVanishingIdeal R;
-- Lambda
L = directedEdgesMatrix R
-- Omega
W = bidirectedEdgesMatrix R
K = inverse (id_(R^3)-L)
S = (transpose K) * W * K
FR = frac(R)
-- V = sum of U_i^T * U_i
V = (transpose U#0)*(U#0);
for i from 1 to #U-1 do (V = V + (transpose U#i)*(U#i));

CrazyExp = (diff(vars(R), numerator(trace((inverse substitute(S, FR)) * V))) * denominator(trace((inverse substitute(S, FR)) * V)) - 
diff(vars(R), denominator(trace((inverse substitute(S, FR)) * V))) * numerator(trace((inverse substitute(S, FR)) * V)) );
CrazyExp = (matrix{{1 / denominator(trace((inverse substitute(S, FR)) * V)) * denominator(trace((inverse substitute(S, FR)) * V))}}) * substitute(CrazyExp, FR);

LL = (substitute((jacobian(matrix{{det(S)}})), FR))*matrix{{(-(#U)/(2*det(S)))}} - (transpose CrazyExp);
print LL
I = ideal(0);
for i to (numgens target LL)-1 do (I = I + ideal(numerator(LL_(i, 0))));
I = saturate(I, det(S));
use R
Sigma = matrix{{s_(1,1), s_(1,2), s_(1,3)}, {s_(1,2), s_(2,2), s_(2,3)}, {s_(1,3), s_(2,3), s_(3,3)}}
S
J = ideal(Sigma - S)
I = I + J
I
dim I
degree I
I == radical I
mingens I
