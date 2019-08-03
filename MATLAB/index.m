clc; clear;

b = 16; % bit in ingresso/uscita dal sistema

LSB = 1/(2^(b-1)); % LSB su 15 bit di informazione ed uno di segno

% Calcolo dei valori xq in ingresso al sistema

alfa = 0:0.1:2*pi; 

x = sin(alfa);

xi = round(x/LSB); xq = xi * LSB; % Output

ex = abs(xq - x); exm = mean(ex);      % Errore di quantizzazione
exassoluto = var(ex); 
exrelativo = exassoluto/exm;
expercentuale = exrelativo * 100;
extot = sum(ex);

% Coefficienti c del filtro quantizzati

c = [0.0135,0.0785,0.2409,0.3344,0.2409,0.0785,0.0135]; % Coefficienti assegnati

ci = round(c/LSB); cq = ci * LSB; % Coefficienti quantizzati

ec = abs(cq - c); ecm = mean(ec);      % Errore di quantizzazione
ecassoluto = var(ec); 
ecrelativo = ecassoluto/ecm;
ecpercentuale = ecrelativo * 100;
ectot = sum(ec);

% Conversione xq in binario

xbin = dec2ms(xq,b-1);

% Conversione cq in binario

cbin = dec2ms(cq,b-1);

% Convoluzione

y = conv(x, c); % Uscita ideale
ybin = dec2ms(y,b-1);

yq = conv(xq, cq); % Uscita quantizzata
yqbin = dec2ms(yq,b-1);

ey = abs(yq - y); eym = mean(ey);      % Errore di quantizzazione
eyassoluto = var(ey); 
eyrelativo = eyassoluto/eym;
eypercentuale = eyrelativo * 100;
eytot = sum(ey);

%%%% test 0.1
% x = [0.1];
% xi = round(x/LSB); xq = xi * LSB;
% yq = conv(xq, cq); % Uscita quantizzata
% xbin = dec2ms(xq,b-1);