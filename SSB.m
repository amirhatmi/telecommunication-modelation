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
%p=sin(100*t);
%p=cos(100*t);
%p=sinc(100*t);
p=sinc(100*t).^2 ;
%p=sign(sin(10*t));
%p=(t+1).*(t>=-1).*(t<0)+(1-t).*(t<1).*(t>=0);% payam


Ac = 10 ;
c = Ac*cos(2*pi*fc*t) ; 
mh = hilbert(p) ; mh = imag(mh) ;
u =  Ac * (p .* cos(2*pi*fc*t) - mh .* sin(2*pi*fc*t)) ;  %% USSB

L =  Ac * (p .* cos(2*pi*fc*t) + mh .* sin(2*pi*fc*t)) ;  %% LSSB
%no=awgn(u,25);
dm = u .* c ;
%dm=L.*c;
f = filter(LPFILTER , dm)/(Ac/2) ; 


figure(1) ; 
subplot(621)
plot(t , p , 'r' , 'LineWidth' , 2);
grid on
xlabel('Time  (Second)') ; ylabel('Amp') ; title('Messgae Signal') ; 
legend('p') ; xlim([-0.4 0.4]) ; 

subplot(622) ;
FFT(p , fs) ;  xlim([-200 200]) ; 



subplot(623)
plot(t , c , 'b' , 'LineWidth' , 2);
grid on
xlabel('Time  (Second)') ; ylabel('Amp') ; title('Carrier Signal') ; 
legend('c') ; xlim([-2e-4 2e-4]) ; 

subplot(624) ;
FFT(c , fs) ;  xlim([-12e3 12e3]) ; 

 
subplot(625)
plot(t , u , 'k' , 'LineWidth' , 2);
grid on
xlabel('Time  (Second)') ; ylabel('Amp') ; title('Modulated Signal') ; 
legend('u') ; xlim([-0.1 0.1]) ; 

subplot(626) ;
FFT(u , fs) ;  xlim([fc-200 , fc+200]) ; 


 
subplot(627)
plot(t , L , 'r' , 'LineWidth' , 2);
grid on
xlabel('Time  (Second)') ; ylabel('Amp') ; title('Modulated Signal') ; 
legend('L') ; xlim([-0.1 0.1]) ; 

subplot(628) ;
FFT(L , fs) ;  xlim([fc-200 , fc+200]) ; 
 


subplot(629)
plot(t , dm , 'b' , 'LineWidth' , 2);
grid on
xlabel('Time  (Second)') ; ylabel('Amp') ; title('DEModulated Signal') ; 
legend('dm') ; xlim([-0.1 0.1]) ; 

subplot(6,2,10) ;
FFT(dm, fs) ; 



 subplot(6,2,11)
plot(t , f , 'k' , 'LineWidth' , 2);
grid on
xlabel('Time  (Second)') ; ylabel('Amp') ; title('filter Signal') ; 
legend('f') ; xlim([-0.1 0.1]) ; 

 
subplot(6,2,12) ;
FFT(f , fs) ;    



 
