clear all;
clc;

syms s t R C A w Uo V

vs(t) = V*heaviside(t); %Direct Voltage Source
vs(t) = V*cos(w*t);     %Alternating Voltage Source
%vs(t) = V*(heaviside(t)-heaviside(t-0.001)); %Pulse Source
%vs(t) = V*dirac(t);     %Impulse Signal
Vs(s) = laplace(vs(t),t,s);

I(s) = (1/R)*(s*Vs(s)-Uo)*(1/(s+1/(R*C)));
Vc(s) = (1/(s+1/(R*C)))*(Vs(s)/(R*C)+Uo);

i(t) = ilaplace(I(s));
vc(t) = ilaplace(Vc(s));

%Capacitor Formula:
vc_2 = (1/C)*int(i(t),0,t)+Uo;
vr_2 = R*i(t);

Vv = 28.2842;
Rv = 10;
Cv = 0.0001;
wv = 2*pi*500;
Uov = 0;

i1(t) = subs(i,[V,R,C,w,Uo],[Vv,Rv,Cv,wv,Uov]);
vc1(t) = subs(vc,[V,R,C,w,Uo],[Vv,Rv,Cv,wv,Uov]);

disp('Transform Completed');

i
vc
vc_2





