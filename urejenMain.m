% main.m
% Definicija vhodnih podatkov  
M = [1.0 1.5 1.0 1.0 1.0 1.2]; % mase palic
L = [1.0 1.5 1.0 1.0 1.0 1.2]; % dolžine palic
obesisceL = [2.4; 3.0];        % levo obesišče [x_0; y_0]
obesisceD = [5.0; 1.2];        % desno obesišče [x_n+1; y_n+1]
w0 = [-1;-1];                  % začetni približek za u in v
tol = 10e-15;

% a) Za vsak posamezen členek verižnice določite njegovo težišče
koordinate_clenkov = diskrVeriznica(w0, obesisceL, obesisceD, L, M);
tezisce = dolociTezisce(koordinate_clenkov);

% Risanje verižnice
figure;
hold on;
risiVeriznica(obesisceL, obesisceD, L, M);

% b) Skozi obesišči verižnice in težišče vsakega posameznega členka napeljite
% interpolacijski polinom p.
% Združimo točke verižnice in obeščišča za interpolacijo
x_koordinate = [obesisceL(1), tezisce(1, :), obesisceD(1)];
y_koordinate = [obesisceL(2), tezisce(2, :), obesisceD(2)];

% Risanje interpolacijskega polinoma
[x_polinoma, y_polinoma] = risanjePolinoma(x_koordinate, y_koordinate);

% c) Izračun dolžine polinoma
dolzina_polinoma = dolzinaPolinoma(polyfit(x_koordinate, y_koordinate, 3), obesisceL(1), obesisceD(1));


% d) Določite zvezno verižnico, ki poteka skozi dani obesišči in ima
% dolžino enako l. Kakšna je razdalja med njnižjo točko polinoma p (gledano
% med obesiščema) in najnižjo točko zvezne verižnice?

% Označimo najnižjo točko interpolacijskega polinoma
[najnizja_tocka_pol, min_value] = najnizjaTockaPolinoma(polyfit(x_koordinate, y_koordinate, 3), obesisceL(1), obesisceD(1));
plot(najnizja_tocka_pol, min_value, 'bo', 'MarkerSize', 5, 'LineWidth', 2, 'DisplayName', 'Najnižja točka polinoma');
xlabel('x');
ylabel('y');
% legend show;

% Narišimo zvezno verižnico in poiščemo njeno najnižjo točko
najnizja_tocka_zvV = zvVeriznica(obesisceL,obesisceD,dolzina_polinoma,tol);

% Izračunamo in označimo razdaljo med najnižjima točkama
line([najnizja_tocka_pol najnizja_tocka_zvV(1)], [min_value najnizja_tocka_zvV(2)], 'Color', 'k', 'LineStyle', '-', 'DisplayName', 'Razdalja med najnižjima točkama');
razdalja = sqrt((najnizja_tocka_pol - najnizja_tocka_zvV(1))^2 + (min_value - najnizja_tocka_zvV(2))^2);
mid_x = (najnizja_tocka_pol + najnizja_tocka_zvV(1)) / 2;
mid_y = (min_value + najnizja_tocka_zvV(2)) / 2;
% text(mid_x, mid_y, sprintf('%.2f', razdalja), 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right');



