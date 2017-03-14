%PROJEKT NR.3 Weronika Borucka #5
clear

%% zadanie 1
projekt2_cz1;
global r_max;
global r_min;
global dy;

r_max = max_x0;
r_min = min_x0;
dy = @(t,y) (r_max-1)*y.^2 + (r_min-1)*y;

clear a a_transp_ max_x0 mid_x0 min_x0 n x0 S
%% zadanie 2

[Tp,Yp] = ode45(dy,[0,2],1);
figure
plot(Tp,Yp,'bo-')
title('wykres dla wartosci domyslnych AbsTol i RelTol')
%domyœlne wartoœci RelTol: 10^(-3), AbsTol10^(-6)

%zmiana RelTol i AbsTol
options = odeset('RelTol',2.22045e-14,'AbsTol',10^(-16));
[T,Y] = ode45(dy, [0,2], 1, options);

figure
plot(Tp,Yp,'*-',T,Y,'go--')
legend('wartosci domyslne','wartoœci zmienione');
title('wykres dla RelTol 2.22045e-14 i AbsTol 10^{-16}')

%wartoœci¹ odniesienia maj¹ byæ jak najdok³adniejsze wartoœci:
Tp = T;
Yp = Y;

%% zadanie 3
h = 0.01;

[Tr,Yr] = Runge(h);
[Tg,Yg] = Gear(h);

figure
plot(Tp,Yp,'b-',Tr,Yr,'r--',Tg,Yg,'g-.')
title('Porównanie metod ode45, Rungego-Kutty i Geara')
legend('ode45','Rungego-Kutty','Gear')

%% zadanie 4
kroki = [0.5,0.2,0.1,0.05,0.02,0.01,0.005,0.002,0.001,0.0005,0.0002,0.0001]; %wartoœci dobrane by by³o widac w skali log
options1 = odeset('RelTol',2.22045e-014,'AbsTol',1e-16);
for i = 1:numel(kroki)
    hi = kroki(i);
    %wywolanie kazdej metody dla kroku obecnie sprawdzanego
    [~,Y] = ode45(dy,(0:hi:2),1,options1);
    [~,yr1] = Runge(hi);
    [~,yg1] = Gear(hi);
%wyliczenie bledow dla metod Rungego-Kutty i Geara
bl_maks_r(i)= norm(Y-yr1',inf);
bl_maks_g(i)= norm(Y-yg1',inf);
bl_sredniokwadr_r(i)= norm(yr1'-Y);
bl_sredniokwadr_g(i)= norm(yg1'-Y);
end

figure
loglog(kroki,bl_maks_r,'r--')
hold on
loglog(kroki,bl_maks_g,'g-.')
xlabel('krok');
ylabel('b³¹d');
legend('Rungego','Geara')
title('Zale¿noœæ wartoœci b³êdu maksymalnego od d³ugoœci kroku h');
hold off

figure
loglog(kroki,bl_sredniokwadr_r,'r--')
hold on
loglog(kroki,bl_sredniokwadr_g,'g-.')
xlabel('krok');
ylabel('b³¹d');
legend('Rungego','Geara')
title('Zale¿noœæ wartoœci b³êdu œredniokwadratowego od d³ugoœci kroku');
hold off