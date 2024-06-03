
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
plot(najnizja_tocka_pol, min_value, 'bo', 'MarkerSize', 5, 'LineWidth', 2, 'DisplayName', 'Interpolacijski polinom');
%text(najnizja_tocka_pol, min_value, sprintf(' (%.2f, %.2f)', najnizja_tocka_pol, min_value), 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'right');

xlabel('x');
ylabel('y');
% legend({'Točke verižnice', 'Levo obesišče', 'Desno obesišče', 'Interpolacijski polinom', 'Najnižja točka polinoma', 'Zvezna verižnica', 'Najnižja točka zvezne verižnice'}, 'Location', 'best');
% title('Razdalja med najnižjima točkama');
% axis([3,4.5,-1,0.5]);
%hold off;
