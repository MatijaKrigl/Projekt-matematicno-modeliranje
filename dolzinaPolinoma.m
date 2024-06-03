function dolzina_polinoma = dolzinaPolinoma(p, a, b)
    % Izračuna dolžino polinoma v danem intervalu
    % dolzina_polinoma = dolzinaPolinoma(p, a, b)
    % izračuna dolžino krivulje polinoma med točkama a in b.
    %
    % Vhod:
    %   p - Koeficienti interpolacijskega polinoma
    %   a - Spodnja meja intervala
    %   b - Zgornja meja intervala
    %
    % Izhod:
    %   dolzina_polinoma - Dolžina krivulje polinoma med točkama a in b

    dp = polyder(p);
    f = @(x) sqrt(1 + polyval(dp, x).^2);
    dolzina_polinoma = integral(f, a, b);
end
