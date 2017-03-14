%PROJEKT NR.2 Weronika Borucka #5


%% zadanie 1
%sprawdzamy wiersz w-ty orginalnej macierzy z wierszem w-tym w macierzy
%zmienionej i patrzymy w którym wierszu najwiêcej elementów siê ró¿ni
clear;
format long;

%sudoku
S = [ 9 1 5 3 7 8 6 2 4;...
      6 3 4 2 9 1 8 5 7;...
      2 8 7 5 4 6 3 1 9;...
      5 6 9 8 3 7 2 4 1;...
      8 7 3 4 1 2 5 9 6;...
      4 2 1 6 5 9 7 8 3;...
      7 4 6 1 2 5 9 3 8;...
      1 5 8 9 6 3 4 7 2;...
      3 9 2 7 8 4 1 6 5];

km = zeros(1,9); %macierz liczby zmian dla wierszy macierzy  
  
for w = 1:9
       for k=1:8
            km(1,w) = abs(S(w,k)-S(w,k+1)) + km(1,w);
       end
end

[~,Imax] = max(km);

x = [1:9]-5;
y = [S(Imax,:) - 5];

X = zeros(9); %macierz x-ow przemnozona przez odpowiednie potegi
a = zeros(1,9); %macierz wspolczynnikow wielomianu
n = 8; %stopien wielomianu

for i = 1:9
    for j = 1:9
        X(i,j) = x(i)^(9-j);
    end
end

a = X\y';

%WYKRES WIELOMIANU
w1 = [-4:0.01:4];

%wielomian interpoluj¹cy - linia ciagla
W = polyval(a,w1);

clear w1 W i j wl km kz k w

%% zadanie 2

n = [8:-1:0]; %potegi wielomianu
a_transp = a';

%wielomian w postaci funkcji zaleznej tylko od x
f = @(x)  sum(a_transp .* x .^ n);

%wyznaczenie przyblizonych miejsc wystêpowania miejsc zerowych
x_0r = roots(a);

otocz_x = x_0r + 0.1;
x_0fz = zeros(1,8);

for i = 1:size(x_0r)
    x_0fz(i) = fzero(f,otocz_x(i));
end

%wybieranie najdok³adniejszego miejsca zerowego z wyników fzero i roots
for i = 1:size(x_0r)
    if abs( f(x_0r(i)) ) >= abs( f(x_0fz(i)) )
        x0(i) = x_0fz(i);
    else
        x0(i) = x_0r(i);
    end
end

clear x_0r x_0fz i otocz_x y x X Imax

%% zadanie 3

%wybor pierwiastka najmniejszego, bliskiego zeru i najwiêkszego
min_x0 = min(x0);
mid_x0 = fzero(f,0);
max_x0 = max(x0);