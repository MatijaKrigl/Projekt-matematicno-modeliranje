% main.m
% Definicija vhodnih podatkov  
M = [1.0 1.5 1.0 1.0 1.0 1.2]; % mase palic
L = [1.0 1.5 1.0 1.0 1.0 1.2]; % dolžine palic
obesisceL = [2.4; 3.0];        % levo obesišče [x_0; y_0]
obesisceD = [5.0; 1.2];        % desno obesišče [x_n+1; y_n+1]
w0 = [-1;-1];                  % začetni približek za u in v
tol = 10e-15;

% Za vsak posamezen členek verižnice določite njegovo težišče
koordinate_clenkov = diskrVeriznica(w0,obesisceL,obesisceD,L,M);
tezisce = dolociTezisce(koordinate_clenkov);
risiVeriznica(obesisceL, obesisceD,L,M );

% Skozi obesišči verižnice in težišče vsakega posameznega členka napeljite
% interpolacijski polinom p.

% Združimo točke verižnice in obeščišča za interpolacijo
x_koordinate = [obesisceL(1), tezisce(1, :), obesisceD(1)];
y_koordinate = [obesisceL(2), tezisce(2, :), obesisceD(2)];

% Uporabimo interpolacijski polinom 
p = polyfit(x_koordinate, y_koordinate, 3);       % tretja stopnje za gladkost
% Ustvarimo vektorja x,y za risanje polinoma
x_polinoma = linspace(min(x_koordinate), max(x_koordinate), 100);
y_polinoma = polyval(p, x_polinoma);     % vrednosti polinoma

% Za risanje točk: definirajmo x_clenki in y_clenki kot koordinate členkov verižnice
x_clenki = koordinate_clenkov(1, :);
y_clenki = koordinate_clenkov(2, :);
% Narišimo točke in interpolacijski polinom
figure;
hold on;
plot(x_clenki, y_clenki, 'ro', 'MarkerSize', 5, 'DisplayName', 'Točke verižnice');
plot(obesisceL(1), obesisceL(2), 'go', 'MarkerSize', 5, 'DisplayName', 'Levo obesišče');
plot(obesisceD(1), obesisceD(2), 'bo', 'MarkerSize', 5, 'DisplayName', 'Desno obesišče');
plot(x_polinoma, y_polinoma, 'b-', 'LineWidth', 2, 'DisplayName', 'Interpolacijski polinom');

% Označimo najnižjo točko interpolacijskega polinoma z modro točko
plot(najnizja_tocka_pol, min_value, 'bo', 'MarkerSize', 5, 'LineWidth', 2, 'DisplayName', 'Najnižja točka polinoma');
%text(najnizja_tocka_pol, min_value, sprintf(' (%.2f, %.2f)', najnizja_tocka_pol, min_value), 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right');

xlabel('x');
ylabel('y');
% legend({'Točke verižnice', 'Levo obesišče', 'Desno obesišče', 'Interpolacijski polinom', 'Najnižja točka polinoma', 'Zvezna verižnica', 'Najnižja točka zvezne verižnice'}, 'Location', 'best');
% title('Razdalja med najnižjima točkama');
% axis([3,4.5,-1,0.5]);
%hold off;


% Izračunajte dolžino l polinoma p med obesiščema
% Izvedeni polinom
dp = polyder(p);

% Izračunajmo dolžino krivulje
f = @(x) sqrt(1 + polyval(dp, x).^2);

% meja za integracijo
a = obesisceL(1);  
b = obesisceD(1);
dolzina_polinoma = integral(f, a, b);

% fprintf('Dolžina polinoma med obesiščema je približno %.4f\n', dolzina_polinoma)  % na 4 decimalna mesta

% Določite zvezno verižnico, ki poteka skozi dani obesišči in ima dolžino
% enako l. Kakšna je razdalja med najniŽjo točko polinoma p (gledano
% med obesiščema) in najnižjo točko zvezne verižnice?

% Najprej poiščimo najnižjo točko interpolacijskega polinoma p
% poiščimo stacionarne točke 
staciaonarne_tocke = roots(dp);

relavantne_stacionarne = [];
% Preverimo vsako staionarno točko, ali je znotraj intervala
for i = 1:length(staciaonarne_tocke)
    if staciaonarne_tocke(i) >= a && staciaonarne_tocke(i) <= b
        relavantne_stacionarne = [relavantne_stacionarne; staciaonarne_tocke(i)];
    end
end

% Izračunajmo vrednosti polinoma v stacionarnih točkah
vrednosti_relavantnih = polyval(p, relavantne_stacionarne);

% Izračunaj vrednosti polinoma na robovih
rob_a = polyval(p, a);
rob_b = polyval(p, b);

% Združimo vse točke in vrednosti
vrednosti_interp_pol = [vrednosti_relavantnih; rob_a; rob_b];
tocke_interp_pol = [relavantne_stacionarne; a; b];

% indeks najnižje vrednosti
[min_value, min_indeks] = min(vrednosti_interp_pol);

% Najnižja točka interpolacijskega polinoma
najnizja_tocka_pol = tocke_interp_pol(min_indeks);
% 
% Vrnemo najnižjo točko interpolacije
fprintf('Najnižja točka polinoma med obesiščema je pri x = %.4f, y = %.4f\n', najnizja_tocka_pol, min_value);
% Komentar: Če bi iskali najnižjo točko dikretne verižnice bi v primeru:
% - sodega števila členkov imeli točko
% - lihega števila členkov imeli palico 

% DoloČimo še zvezno veriŽnico, ki poteka skozi dani obesiŠČi in ima dolŽino
% enako l.
najnizja_tocka_zvV = zvVeriznica(obesisceL,obesisceD,dolzina_polinoma,tol);

% Označevanje razdalje med najnižjima točkama
line([najnizja_tocka_pol najnizja_tocka_zvV(1)], [min_value najnizja_tocka_zvV(2)], 'Color', 'k', 'LineStyle', '-', 'DisplayName', 'Razdalja med najnižjima točkama');
razdalja = sqrt((najnizja_tocka_pol - najnizja_tocka_zvV(1))^2 + (min_value - najnizja_tocka_zvV(2))^2);
mid_x = (najnizja_tocka_pol + najnizja_tocka_zvV(1)) / 2;
mid_y = (min_value + najnizja_tocka_zvV(2)) / 2;
text(mid_x, mid_y, sprintf('%.2f', razdalja), 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right');


