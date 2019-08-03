% la funzione converte un valore decimale x su b bit in modulo e segno
function y = dec2ms(x,b)

    negative_number = x;
    for i = 1:length(x)
        if(x(i) < 0)
            x(i) = -1*x(i);
            negative_number(i) = 1;
        else
            negative_number(i) = 0;
        end
    end
    
    y = dec2q(x,0,b,'bin');
    
    for i = 1:length(x)
        if(negative_number(i) == 1)
            y(i,1) = '1';
        end
    end    

end