clc;
clear;
close all;
load('MyFilter.mat');
fs = 100e3 ; 
fc = 10e3  ;
T0 = -1 ; 
Tf =  1 ; 
Ts = 1/fs ; 
t = T0:Ts:Tf ; 
p=sin(100*t);
%p=cos(100*t);
%p=sinc(100*t);
%p=sinc(100*t).^2 ;
%p=sign(sin(10*t));
%p=(t+1).*(t>=-1).*(t<0)+(1-t).*(t<1).*(t>=0);% payam
Q=100;
Ac=10;
m=Ac * cos(2*pi*fc*t + 2*pi*Q*p) ;  %% PM modulation
m1=Ac * cos(2*pi*fc*t + 2*pi*Q*p) ;  %% PM modulat
m(end+1) = m(end) ; 
dm = diff(m)/Ts; %demodulation
po= abs(hilbert(dm)) ; %% posh dm
pn = 1/Q*(po/(2*pi*Ac)-fc) ; 


 k= pn-mean(pn) ; 

%f = filter( HPFilter,pn)/(Ac/2) ; 







figure(1) ; 
subplot(321)
plot(t , p , 'r' , 'LineWidth' , 2);
grid on
xlabel('Time  (Second)') ; ylabel('Amp') ; title('Messgae Signal') ; 
legend('p') ;  


subplot(323)
plot(t , m1 , 'b' , 'LineWidth' , 2);
grid on
xlabel('Time  (Second)') ; ylabel('Amp') ; title('Modulated Signal') ; 
legend('m') ; xlim([-500e-5 500e-5]) ; 

subplot(325)
plot(t , k, 'k' , 'LineWidth' , 2);
grid on
xlabel('Time  (Second)') ; ylabel('Amp') ; title('demodulated Signal') ; 
legend('k') ;  


 
subplot(322) ;
FFT(p , fs) ;  xlim([-20 20]) ; 

 
subplot(324) ;
FFT(m , fs) ;  xlim([10e3-200 10e3+200]) ; 


subplot(326) ;
FFT(k , fs) ;   xlim([-20 20]) ; 
 







