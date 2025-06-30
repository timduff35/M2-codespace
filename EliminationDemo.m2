-- Example from the documenation of eliminate
restart
R = QQ[x,a,b,c,d]
f = x^2+a*x+b
g = x^2+c*x+d	
eliminate(x,ideal(f,g))

-- Regular representation of ZZ/2 with mappings
restart
R = QQ[x_1..x_2, y_1..y_2]

I1 = ideal(y_1 - x_1, y_2 - x_2)
I2 = ideal(y_1 - x_2, y_2 - x_1)

I=intersect(I1,I2)
R = ring I
S = QQ[x_1..x_2]

f= map(S, R, {x_1, x_2, 0 , 0})
L= flatten entries gens I
L / f

-- Regular representation of ZZ/2 with eliminate command
restart
R = QQ[x_1..x_2, y_1..y_2]

I1 = ideal(y_1 - x_1, y_2 - x_2)
I2 = ideal(y_1 - x_2, y_2 - x_1)
I=intersect(I1,I2)+ideal(y_1..y_2)
eliminate({y_1, y_2}, I)


-- Regular representation of ZZ/2 exterior algebra with mappings
R = QQ[x_1..x_2, y_1..y_2, SkewCommutative=>true]

I1 = ideal(y_1 - x_1, y_2 - x_2)
I2 = ideal(y_1 - x_2, y_2 - x_1)

I=intersect(I1,I2)
R = ring I
S = QQ[x_1..x_2, SkewCommutative=>true]

f= map(S, R, {x_1, x_2, 0 , 0})
L= flatten entries gens I
L / f

-- Regular representation of ZZ/2 with eliminate command
restart
R = QQ[x_1..x_2, y_1..y_2, SkewCommutative=>true]

I1 = ideal(y_1 - x_1, y_2 - x_2)
I2 = ideal(y_1 - x_2, y_2 - x_1)
I=intersect(I1,I2)+ideal(y_1..y_2)
eliminate({y_1, y_2}, I)