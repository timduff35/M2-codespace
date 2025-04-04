

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

GCD = (a, b) -> (
    while b != 0 do (
        t = b;
        b = a % b;
        a = t;
    );
    a
)

sq(3, 4)

LCM = (i,j) -> (
    k = sq(i,j)/GCD(i,j)
    k
)

LCM(8,16)