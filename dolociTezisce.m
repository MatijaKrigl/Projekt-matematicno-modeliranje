function tezisce = dolociTezisce(koordinate_clenkov)

    % Funkcija za izračun težišč posameznih členkov veriženice
    % vhod:
    % - x: matrika koordinat vozlišč
    % izhod:
    % - tezisca: 2x(N-1) matrika težišč posameznih členkov

    % Izračunamo sredino vsakega členka (težišče)
    x_sredina = (koordinate_clenkov(1,1:end-1) + koordinate_clenkov(1,2:end)) / 2;
    y_sredina = (koordinate_clenkov(2,1:end-1) + koordinate_clenkov(2,2:end)) / 2;
    
    tezisce = [x_sredina; y_sredina];
end

% Komentar: če bi želeli s for zanko
%     n = size(koordinate_clenkov, 2) - 1;     % število členkov
%     tezisca = zeros(2, n);  
%     for i = 1:n
%         tezisca(:, i) = (koordinate_clenkov(:, i) + koordinate_clenkov:, i+1)) / 2;
%     end