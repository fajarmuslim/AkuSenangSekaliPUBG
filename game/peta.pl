print_x :- 
	write('x').
	
minimum_peta(0).
maksimum_peta(21).


print_tepi(0).

print_tepi(X) :- 
	print_x,
	X1 is X - 1,
	print_tepi(X1).
	
print_peta :- 
	maksimum_peta(A),
	print_tepi(A),
	print_tepi(A).
	
