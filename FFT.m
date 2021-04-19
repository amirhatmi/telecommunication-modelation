function Z = FFT(m , fs)
M = fftshift(fft(m));
N = numel(m) ;
freq = (2*pi/N * (-N/2:N/2-1))/(2*pi)*fs;
plot(freq , abs(M)/max(abs(M)) , 'LineWidth' , 2) ;
grid on
xlabel('Freq  (Hz)') ; ylabel('abs(M)') ; title('Messgae Spectrum') ;
legend('M(f)') ; % xlim([-3000 3000]) ;
Z = [];
end