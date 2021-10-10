%Lotka-Volterra two species model

function J = LK2_Jacobian(N1, N2, r1, r2, alpha12, alpha21, K1, K2)

if(~exist("r1"))
    r1 = 1;end
if(~exist("r2"))
    r2 = 1;end
if(~exist("alpha12"))
    alpha12 = 1.4;end
if(~exist("alpha21"))
    alpha21 = 1.2;end
if(~exist("K1"))
    K1 = 1;end
if(~exist("K2"))
    K2 = 1;end

J = [r1*(K1-2*N1-alpha12*N2)/K1, -r1*alpha12*N1/K1; 
     -alpha21*N2*r2/K2, -r2*(2*N2-alpha21*N1)/K2];