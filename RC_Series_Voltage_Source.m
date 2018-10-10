clear all;
close all;
clc;

syms s t R C w Uo A

%----------------- Voltage Sources---------------- :
vs(t) = A*heaviside(t); %Direct Voltage Source
vs(t) = A*sin(w*t);     %Alternating Voltage Source
%vs(t) = A*(heaviside(t)-heaviside(t-0.001)); %Pulse Source
%vs(t) = A*dirac(t);     %Impulse Signal
Vs(s) = laplace(vs(t));

disp('Source Laplace Transform Completed');
%-----------------Mesh Analysis-----------------  :
I(s) = (1/R)*(s*Vs(s)-Uo)*(1/(s+1/(R*C)));
i(t) = ilaplace(I(s));

i_R_mesh(t) = i(t);
i_C_mesh(t) = i(t);
u_R_mesh(t) = R*i_C_mesh(t);
u_C_mesh(t) = (1/C)*int(i_C_mesh,[0,t]) + Uo;

disp('Mesh Analysis Completed');

%----------------- Nodal Analysis---------------- :
V_B(s) = (Vs(s)/(R*C)+Uo)*(1/(s+1/(R*C)));
v_B(t) = ilaplace(V_B(s));
v_A(t) = vs(t);

u_R_nodal(t) = v_A(t) - v_B(t);
u_C_nodal(t) = v_B(t) - 0;
i_R_nodal(t) = (1/R)*u_R_nodal(t);
i_C_nodal(t) = C*diff(u_C_nodal);

disp('Noda Analysis Completed');
%----------------- Numeric Application----------- :
Av = 28.2842;
Rv = 10;
Cv = 0.0001;
wv = 2*pi*50;
Uov = 0;

vs1(t) =  subs(vs,[R,C,w,A,Uo],[Rv,Cv,wv,Av,Uov]);
v1(t) = subs(u_C_nodal,[R,C,w,A,Uo],[Rv,Cv,wv,Av,Uov]);
i1(t) = subs(i_C_mesh,[R,C,w,A,Uo],[Rv,Cv,wv,Av,Uov]);

disp('Numeric Substitution Completed');
%-----------------Visualization----------------- :
j=1;
for tv = 0:0.0001:0.04
    a(j) = vpa(v1(tv));
    vs_list(j) = vpa(vs1(tv));
    t_list(j) = tv;
    j = j + 1;
end
t_list = t_list*1000;   % In milisecs
plot(t_list,a,t_list,vs_list)
%plot(t_list,a)






