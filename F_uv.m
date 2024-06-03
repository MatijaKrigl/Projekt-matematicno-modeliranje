function z = F_uv(w,obesisceL,obesisceD,L,vsote_mi)

% function z = F_uv(w,obesisceL,obesisceD,L,vsote_mi)
% F_uv vrne vrednost vektorske funkcije za diskretno veriznico,
% z = F(w) = [U(u,v);V(u,v)], z \in R^2, w=(u,v) \in R^2
% Po knjigi Matematicno modeliranje (E. Zakrajsek).
%
% vhodni podatki:
% w=[u;v], kjer sta u in v parametra funkcije F(w) = F(u,v),
% obesisceL = levo obesisce [x_0;y_0],
% obesisceD = desno obesisce [x_n+1;y_n+1],
% L = dolzine palic (vektor),
% vsote_mi = [0,mi_1,mi_1+mi_2,...] je vektor delnih vsot mi-jev.

% izhodni podatki:
% z = F(w) = [U(u,v);V(u,v)]

u = w(1);
v = w(2);
kvoc = v-u*vsote_mi;

% zapisemo vektor xi=[xi_1,...,xi_n+1]
xi = L./sqrt(1+kvoc.^2);

% zapisemo vektor eta=[eta_1,...,eta_n+1] 
eta = xi.*kvoc;

% vrnemo vektor z = [U(u,v);V(u,v)]
z = [sum(xi)-(obesisceD(1)-obesisceL(1)); sum(eta)-(obesisceD(2)-obesisceL(2))];