clc;
clear;
close all;
load('MyFilter.mat');
fs=100e3;      %100kHz  
fc=10e3;       %10kHz  
t0=-1;
t1=1;
ts=1/fs;
Ac=20;
t=t0:ts:t1; 
%p=sin(100*t);
%p=cos(100*t);
%p=sinc(100*t);
p=sinc(100*t).^2;
%p=sign(sin(10*t));
%p=(t+1).*(t>=-1).*(t<0)+(1-t).*(t<1).*(t>=0);% payam
N = numel(p) ;
freq = (2*pi/N * (-N/2:N/2-1))/(2*pi)*fs;%%»«“Â ›—ò«‰” 
pf=abs(fftshift(fft(p)));%% »œ?· ›Ê—?Â 

c=Ac*cos(2*pi*fc*t);
cf=abs(fftshift(fft(c)));%% »œ?· ›Ê—?Â 

m=p.*c; %       modele      u(t)=p(t)*c(t)  zarb dakheli ya dat
mf=abs(fftshift(fft(m)));

no=awgn(m,25);% noise gosi
nof=abs(fftshift(fft(no)));

dm=no.*c;%demodele
dmf=abs(fftshift(fft(dm)));
f=real(hilbert(dm));
%f=filter(LPFILTER , dm)/200;%filter
ff=abs(fftshift(fft(f)));

figure(1) 

subplot(621)
plot(t , p , 'r' , 'LineWidth',2 );
grid on
xlabel('Time  (Second)') ; ylabel('Amp') ; title('Messgae Signal') ; 
legend('p') ; xlim([-0.4 0.4]) ;

subplot(622)
plot(freq, pf , 'r' , 'LineWidth',2 );
grid on
xlabel('Freq  (Hz)') ; ylabel('p') ; title('spectrum of the message signal') ; 
legend('pf') ; 



subplot(623)
plot(t , c , 'b' , 'LineWidth',2 );
grid on
xlabel('Time  (Second)') ; ylabel('Amp') ; title('carrier Signal') ; 
legend('c') ; xlim([-2e-4 2e-4]) ; 

subplot(624)
plot(freq , cf , 'b' , 'LineWidth',2 );
grid on
xlabel('Freq  (Hz)') ; ylabel('c') ; title('spectrum carrier Signal') ; 
legend('cf') ;   



subplot(625)
plot(t , m , 'k' , 'LineWidth' ,2);
grid on
xlabel('Time  (Second)') ; ylabel('Amp') ; title('Modullated Signal') ; 
legend('m') ; xlim([-0.4 0.4]) ; 

subplot(626)
plot(freq , mf , 'k' , 'LineWidth',2 );
grid on
xlabel('Freq  (Hz)') ; ylabel('m') ; title('spectrum Modullated Signal') ; 
legend('mf') ; 



subplot(627)
plot(t , no , 'r' , 'LineWidth' ,2);
grid on
xlabel('Time  (Second)') ; ylabel('Amp') ; title('noise Signal') ; 
legend('no') ; xlim([-0.4 0.4]) ; 

subplot(628)
plot(freq , nof , 'r' , 'LineWidth',2 );
grid on
xlabel('Freq  (Hz)') ; ylabel('no') ; title('spectrum noise Signal') ; 
legend('nof') ;  



subplot(629)
plot(t , dm, 'b' , 'LineWidth' ,2);
grid on
xlabel('Time  (Second)') ; ylabel('Amp') ; title('deModulated Signal') ; 
legend('dm') ; xlim([-0.4 0.4]) ;

subplot(6,2,10)
plot(freq , dmf , 'b' , 'LineWidth',2 );
grid on
xlabel('Freq  (Hz)') ; ylabel('dm') ; title('spectrum deModulated Signal') ; 
legend('dmf') ; 



subplot(6  ,2 ,11)
plot(t , f , 'k' , 'LineWidth' ,2);
grid on
xlabel('Time  (Second)') ; ylabel('Amp') ; title('filter Signal') ; 
legend('f') ; 

subplot(6,2,12)
plot(freq , ff , 'k' , 'LineWidth',2 );
grid on
xlabel('Freq  (Hz)') ; ylabel('f') ; title('spectrum filter Signal') ; 
legend('ff') ;   xlim([-12e2 12e2]) ;
