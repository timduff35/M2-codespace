

R = QQ[x,y,z]
I = ideal(x,y)
f = x+1
-- (oo % I) == 0

if (((f % I) == 0) == true) then (
    s= " in the ideal";
	print("element is" | s);
    p = "test2";
	) else (
	print("element is not" | s);
	)

sq = (i,j) -> (
    square := i*j;
    square
)

square
sq(3, 4)