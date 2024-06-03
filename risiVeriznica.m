function risi_veriznica(levo,desno,L,M)
    % narisemo sliko veriznice
    %
    % Vhodni parametri:
    % levo je levo obesišče, (x_0,y_0);
    % desno je desno obesišče (x_n+1, y_n+1);
    % L je seznam dolžin palic;
    % M je seznam mas palic.
    
    x = diskrVeriznica([-1; -1],levo,desno,L,M);
    plot(x(1,:),x(2,:),'o-');
    % axis([0,6,-2,4]);
end