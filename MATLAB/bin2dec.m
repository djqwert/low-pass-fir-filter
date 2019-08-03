% la funzione converte una stringa binaria x (tipo '11101110111') su b bit in decimale
function [] = bin2dec(x, b)

    y = zeros(1,b-1);
    for i = 2:b
        y(1,i-1) = str2num(x(:,i))*2^(-i+1);
    end

    y = sum(y);

    if(x(1,1) == '1')
        y = -1*y
    else
        y
    end

end