%initializing constants
gk = .036;
gna = .120;
gl = .0003;
Ek = -.012;
Ena = .115;
El = .0106;
Vrest = -.070;
%assume typical fixed membrane capacitance
Cm = .000002;

%steady state simulation
Vm = Vrest;
%gating variables equations
am = .1*((25-Vm)/(exp((25-Vm)/10)-1));
Bm = 4*exp(-Vm/18);
an = .01*((10-Vm)/(exp((10-Vm)/10)-1));
Bn = .125*exp(-Vm/80);
ah = .07*exp(-Vm/20);
Bh = 1/(exp((30-Vm)/10)+1);
%solving for n, m, and h at steady state
n = an/(an+Bn);
m = am/(am+Bm);
h = ah/(ah+Bh);
%currents equations
Ina = (m^3)*gna*h*(Vm-Ena);
Ik = (n^4)*gk*(Vm-Ek);
Il = gl*(Vm-El);
Icm = 0;
Iion = Ina+Ik+Il;
%show plot of Gna/Gk
Gk = gk*(n^4);
Gna = (m^3)*h*gna;
plot([0,.1],[(Gna/Gk),(Gna/Gk)]);
%show plot of membrane potential
figure;
plot([0,.1],[Vm,Vm]);

%step pulse stimulation of 5uA for .5ms

