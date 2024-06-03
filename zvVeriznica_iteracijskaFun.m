function z = zvVeriznica_iteracijskaFun(a,A,b,B,L,z0,tol)

% function z = zvVeriznica_iteracijskaFun(T1,T2,l,z0,tol)
% Iteracijska funkcija zvVeriznica_iteracijskaFun resi enacbo z=asinh(ro*z)
% za zvezno veriznico.
% 
% Vhod
% [a;A]:    levo obesisce
% [b;B]:    desno obesisce
% L:        dolzina veriznice
% z0:       zacetni priblizek
% tol:      toleranca pri ustavitvi iteracije
%
% Izhod
% z:        numericna resitev enacbe z=asinh(ro*z)

ro = L/(b-a)*sqrt(1-((B-A)/L).^2);
razlika = Inf;
while razlika>tol
    z = asinh(ro*z0);
    razlika = abs(z-z0);
    z0 = z;
end