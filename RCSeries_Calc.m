clear all;
clc;

syms s t R C A w Uo

vs(t) = A*cos(w*t);
Vs(s) = laplace(vs(t));

I(s) = (1/R)*(s*Vs(s)-Uo)*(1/(s+1/(R*C)));

i(t) = ilaplace(I(s));

Av = 28.2842;
Rv = 10;
Cv = 0.0001;
wv = 2*pi*50;
Uov = 0;

i1(t) = subs(i,[A,R,C,w,Uo],[Av,Rv,Cv,wv,Uov]);

disp('Transform Completed');


j=1;
for tv = 0:0.001:0.1
    a(j) = vpa(i1(tv));
    j = j + 1;
end
plot(a)






