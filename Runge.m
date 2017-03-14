%metoda Rungego-Kutty rzêdu 6go

function [tr,yr] = Runge(h)
global dy;  %funkcja y' potrzebna do wyliczenia wspó³czynników k1, k2, ..., k6
w = [19/200 0 3/5 -243/400 33/40 7/80]; %wspolczynniki potrzebne do formuly
tr = 0:h:2;

yr = 1;     %punkt startowy <- wynika on z wykresu dla dok³adnego rozwi¹zania równania funkcj¹ ode

%definicja kolejnych wspó³czynników RK6
for i = 1:(numel(tr)-1)
  
  k1 = dy(tr(i), yr(i));
  k2 = dy(tr(i)+(2*h)/9, yr(i)+((2*h)/9)*k1);
  k3 = dy(tr(i)+h/3, yr(i)+((3*h)/12)*(k1+3*k2));
  k4 = dy(tr(i)+(5*h)/9, yr(i) + h*((55/324)*k1 - (25/108)*k2 + (50/81)*k3));
  k5 = dy(tr(i)+(2*h)/3, yr(i) + h*((83/330)*k1 - (33/22)*k2 + (61/66)*k3 + (9/110)*k4));
  k6 = dy(tr(i)+h, yr(i) + h*((-19/28)*k1 + (9/4)*k2 + (1/7)*k3 - (27/7)*k4 + (22/7)*k5));
  
  yr(i+1) = yr(i) + h*(w(1)*k1 + w(2)*k2 + w(3)*k3 + w(4)*k4 + w(5)*k5 + w(6)*k6);  %formu³a Rungego-Kutty rzêdu 5go
end    

end
