function [x_polinoma, y_polinoma] = risanjePolinoma(x_koordinate, y_koordinate)

    % Izračuna in nariše interpolacijski polinom
    % [x_polinoma, y_polinoma] = risanjePolinoma(x_koordinate, y_koordinate)
    % izračuna koordinate točk interpolacijskega polinoma in jih nariše.
    %
    % Vhod:
    %   x_koordinate - Vektor x koordinat, vključno z obeščišči in težišči členkov
    %   y_koordinate - Vektor y koordinat, vključno z obeščišči in težišči členkov
    %
    % Izhod:
    %   x_polinoma - Vektor x koordinat za risanje polinoma
    %   y_polinoma - Vektor y koordinat za risanje polinoma
    
    p = polyfit(x_koordinate, y_koordinate, 3);
    x_polinoma = linspace(min(x_koordinate), max(x_koordinate), 100);
    y_polinoma = polyval(p, x_polinoma);
    plot(x_polinoma, y_polinoma, 'b-', 'LineWidth', 2, 'DisplayName', 'Interpolacijski polinom');
end
