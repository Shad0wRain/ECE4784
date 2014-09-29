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
Iion = Ina+Ik+Il;
Icm = 0;
Itotal = Iion + Icm;
%show plot of Gna/Gk
Gk = gk*(n^4);
Gna = (m^3)*h*gna;
plot([0,.1],[(Gna/Gk),(Gna/Gk)]);
%show plot of membrane potential
figure;
plot([0,.1],[Vm,Vm]);

%step pulse stimulation of 5uA for .5ms starting at t = .5ms
%create arrays for values to change with time hat will be plotted
Vm = zeros(0,60);
Gk = zeros(0,60);
Gna = zeros(0,60);
%for loop to collect change in values
i = 0;
for t=0:.00025:.1
   i = i+1;
   if t<.005
       Vm(i) = Vrest;
   end
   if t==.0005
       Ina = (m^3)*gna*h*(Vm(i-1)-Ena);
       Ik = (n^4)*gk*(Vm(i-1)-Ek);
       Il = gl*(Vm(i-1)-El);
       Iion = Ina+Ik+Il;
       Istim = .000005;
       Itotal = Iion+Istim;
       Vm(i) = Vm(i-1)+((Istim/Cm)*.00025);
   end
   if t==.00075
       Ina = (m^3)*gna*h*(Vm(i-1)-Ena);
       Ik = (n^4)*gk*(Vm(i-1)-Ek);
       Il = gl*(Vm(i-1)-El);
       Iion = Ina+Ik+Il;
       Istim = .000005;
       Vm(i) = Vm(i-1)+((Istim/Cm)*.00025);
   end
   if t>.00075
      Vm(i) = Vrest;
   end
   %calculate a and B values
   am = .1*((25-Vm(i))/(exp((25-Vm(i))/10)-1));
   Bm = 4*exp(-Vm(i)/18);
   an = .01*((10-Vm(i))/(exp((10-Vm(i))/10)-1));
   Bn = .125*exp(-Vm(i)/80);
   ah = .07*exp(-Vm(i)/20);
   Bh = 1/(exp((30-Vm(i))/10)+1);
   %calculate m,n,h values
   n = an/(an+Bn);
   m = am/(am+Bm);
   h = ah/(ah+Bh);
   %calculate current Gna and Gk
   Gk(i) = gk*(n^4);
   Gna(i) = (m^3)*h*gna;
end
time = 0:.00025:.1;
figure;
plot(time,Gk);
hold on;
plot(time,Gna);
hold off;
figure;
plot(time,Vm);