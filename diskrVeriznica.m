function x = diskrVeriznica(w0,obesisceL,obesisceD,L,M)

% function x = diskrVeriznica(w0,obesisceL,obesisceD,L,M)
% diskrVeriznica resi problem diskretne veriznice: preko fsolve najde u in v, tako da
% F(u,v) = [0; 0], nato veriznico narise.
% Po knjigi Matematicno modeliranje (E. Zakrajsek).

% vhod:
% w0 = [u0;v0] zacetna priblizka,
% obesisceL = [x_0;y_0],
% obesisceD = [x_n+1;y_n+1],
% L = dolzine palic (vektor).
% M = mase palic (vektor).
%
% izhod:
% x je 2x(n+2) tabela koordinat vozlisc.

% vektor mi-jev 'mi' in vektor delnih vsot 'vsote_mi' (vsote_mi = [0,mi_1,mi_1+mi_2,...]; ukaz cumsum)
[n,m] = size(L);
mi = zeros(1,m-1);
for i=1:m-1
    mi(i) = (M(i) + M(i+1))/2;
end
vsote_mi = [0 cumsum(mi)];

% iskanje nicle F(u,v) = [U(u,v);V(u,v)]
F = @(w) F_uv(w,obesisceL,obesisceD,L,vsote_mi);
w = fsolve(F,w0);
u = w(1); 
v = w(2);

% izracunamo x-e
n = size(L,2);
ksi = zeros(1,n);
for i=1:n
    ksi(i) = L(i) ./ (sqrt(1 + (v - u.*vsote_mi(i)).^2));
end

eta = zeros(1,n);
for i=1:n
    eta(i) = ksi(i).*(v - u.*vsote_mi(i));
end

x = obesisceL(1) + cumsum(ksi);
y = obesisceL(2) + cumsum(eta);
x = [obesisceL(1) x; obesisceL(2) y];

