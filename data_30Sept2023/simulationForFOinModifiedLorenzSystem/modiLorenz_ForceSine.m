function dx = modiLorenz_ForceSine(t,x,Beta,FO_mag,FO_freq)

    w = 2*pi*FO_freq;


    dx = [
            x(4);
            x(5);
            x(6);
            Beta(1)*(x(5)-x(4)) + FO_mag*sin(w*t);
            x(4)*(Beta(2)-x(6))-x(5);
            x(4)*x(5)-Beta(3)*x(6);
        ];
end