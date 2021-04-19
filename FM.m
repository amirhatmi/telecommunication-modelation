clc;
clear;
close all;
load('MyFilter.mat');%%filterDesigner
fs = 100e3 ; 
fc = 10e3  ;
T0 = -1 ; 
Tf =  1 ; 
Ts = 1/fs ; 
t = T0:Ts:Tf ; 


p = cos(100*t) ;
p_int = 1/(100) * sin(100*t) ; 
Ac = 10 ;  kf = 100 ;
m = Ac * cos(2*pi*fc*t + 2*pi*kf*p_int) ;  %% FM modulation
m1= Ac * cos(2*pi*fc*t + 2*pi*kf*p_int) ;  %% FM modulation

%%FM  demodulation
m(end+1) = m(end) ; 
dm = diff(m)/Ts; 
po = abs(hilbert(dm)) ; 
pn = 1/kf*(po/(2*pi*Ac)-fc) ; 
 k= (pn-mean(pn)) ;




figure(1) ; 
subplot(321)
plot(t , p , 'r' , 'LineWidth' , 2);
grid on
xlabel('Time  (Second)') ; ylabel('Amp') ; title('Messgae Signal') ; 
legend('p') ; xlim([-1 1]) ; 

subplot(323)
plot(t , m1 , 'b' , 'LineWidth' , 2);
grid on
xlabel('Time  (Second)') ; ylabel('Amp') ; title('Modulated Signal') ; 
legend('m') ; xlim([-500e-6 500e-6]) ; 
subplot(325)
plot(t ,k, 'k' , 'LineWidth' , 2);
grid on
xlabel('Time  (Second)') ; ylabel('Amp') ; title('demodulated Signal') ; 
legend('k') ;  ylim([-1 1]) ;

figure(1) ; 
subplot(322) ;
FFT(p , fs) ;  xlim([-20 20]) ; 

figure(1) ; 
subplot(324) ;
FFT(m, fs) ;  xlim([10e3-200 10e3+200]) ; 

figure(1) ; 
subplot(326) ;
FFT(k , fs) ; xlim([-20 20]) ;


