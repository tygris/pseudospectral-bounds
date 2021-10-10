%Lotka-Volterra two species model analysis
%Natalie Wellen

K1 =1; K2 = 1;
alpha12 = 1.4; alpha21 = 1.2;

N1bar = (K1 - alpha12)/(1-alpha12*alpha21);
N2bar = 1-alpha21*N1bar;

Jbar = LK2_Jacobian(N1bar, N2bar)

eigtool(Jbar)