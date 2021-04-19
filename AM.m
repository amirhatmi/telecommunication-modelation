clc;
clear;
close all;

fs=100;      %100kHz  
fc=10;       %10kHz  
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

%sh=0.6 
%p=p*sh
pn=p/max(abs(p));%normalized


c=Ac*cos(2*pi*fc*t);
cf=abs(fftshift(fft(c)));

m=pn.*c;
mf=abs(fftshift(fft(m)));
u=m+c;
%u =  Ac * (1 +sh*pn).*cos(2*pi*fc*t);
uf=abs(fftshift(fft(u)));

no=awgn(u,25);
%no=0.02.*randn(1,length(u));% noise gosi
nof=abs(fftshift(fft(no)));

d=abs(no);
RC=1e-3;  %%1/fc<<RC<<1/w   ,10^-3<<RC<<10^-2   
T = tf(1 , [RC 1]);

f= lsim(T , d , t) ;
f=f - f(end)   ; 
dm= f * p(100)/f(100);
dmf=abs(fftshift(fft(dm)));



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
plot(t , m, 'k' , 'LineWidth' ,2);
grid on
xlabel('Time  (Second)') ; ylabel('Amp') ; title('Modullated Signal') ; 
legend('m') ; xlim([-0.4 0.4]) ; 

subplot(626)
plot(freq , mf , 'k' , 'LineWidth',2 );
grid on
xlabel('Freq  (Hz)') ; ylabel('m') ; title('spectrum Modullated Signal') ; 
legend('mf') ; 


subplot(627)
plot(t , u , 'r' , 'LineWidth' ,2);
grid on
xlabel('Time  (Second)') ; ylabel('Amp') ; title(' Signal') ; 
legend('u') ; 

subplot(628)
plot(freq , nof , 'r' , 'LineWidth',2 );
grid on
xlabel('Freq  (Hz)') ; ylabel('u') ; title('spectrum  Signal') ; 
legend('uf') ;  

subplot(629)
plot(t , no , 'b' , 'LineWidth' ,2);
grid on
xlabel('Time  (Second)') ; ylabel('Amp') ; title('noise Signal') ; 
legend('no') ;

subplot(6,2,10)
plot(freq , nof , 'b' , 'LineWidth',2 );
grid on
xlabel('Freq  (Hz)') ; ylabel('no') ; title('spectrum noise Signal') ; 
legend('nof') ;  



subplot(6  ,2 ,11)
plot(t , dm , 'k' , 'LineWidth' ,2);
grid on
xlabel('Time  (Second)') ; ylabel('Amp') ; title('posh Signal') ; 
legend('dm') ; 

subplot(6,2,12)
plot(freq , dmf , 'k' , 'LineWidth',2 );
grid on
xlabel('Freq  (Hz)') ; ylabel('') ; title('spectrum posh Signal') ; 
legend('dmf') ;   xlim([-12e2 12e2]) ;

