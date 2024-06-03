function [najnizja_tocka_pol, min_value] = najnizjaTockaPolinoma(p, a, b)

    % Izračuna najnižjo točko interpolacijskega polinoma
    % [najnizja_tocka_pol, min_value] = najnizjaTockaPolinoma(p, a, b)
    % izračuna najnižjo točko polinoma v danem intervalu.
    %
    % Vhod:
    %   p - Koeficienti interpolacijskega polinoma
    %   a - Spodnja meja intervala
    %   b - Zgornja meja intervala
    %
    % Izhod:
    %   najnizja_tocka_pol - x koordinata najnižje točke polinoma
    %   min_value - y vrednost (vrednost polinoma) v najnižji točki
    dp = polyder(p);
    stacionarne_tocke = roots(dp);

    % Filtriramo stacionarne točke znotraj intervala [a, b]
    stacionarne_tocke = stacionarne_tocke(stacionarne_tocke >= a & stacionarne_tocke <= b);
    
    % Vrednosti polinoma v stacionarnih točkah in na robovih intervala
    values = [polyval(p, stacionarne_tocke); polyval(p, a); polyval(p, b)];
    points = [stacionarne_tocke; a; b];
    
    [min_value, min_index] = min(values);
    najnizja_tocka_pol = points(min_index);
end
