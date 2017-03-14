%metoda Geara

function [tg,yg] = Gear(h)

global dy;
global r_max;
global r_min;
tg = 0:h:2;
yg = zeros(1,numel(tg));

%pierwszy krok metody Geara
yg(1) = 1;      %punkt startowy
f1 = @(y) yg(1) + h*((r_max-1)*y.^2 + (r_min-1)*y) - y; %funkcja dla Geara zamkniêtego rzêdu 1go, po rozwik³aniu

%drugi krok metody Geara
yg(2) = fzero(f1, yg(1) + h*dy(yg(1),tg(1)));    %drugi punkt - Gear otwarty rzedu 1go

for i = 2: numel(tg)-1    
    %równanie dla metody rzêdu 3go
    f = @(y) (4*yg(i) - yg(i-1) + 2*h*((r_max-1)*y.^2 + (r_min-1)*y))/3 - y;  % Gear zamkniety rzedu 2go
    yg(i+1) = fzero(f, yg(i-1)+ 2*h*dy(yg(i),tg(i)));   %Gear otwarte rzedu 2go
end