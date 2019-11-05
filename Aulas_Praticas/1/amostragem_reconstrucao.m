clear all;close all;clc;

% Exemplo de amostragem e quantização 
td=0.002; % intervalo entre os pontos do sinal "analógico"
t=td:td:1; % inervalo de 1 segundo
xsig=sin(2*pi*t)-sin(2*3*pi*t); % seno de 1Hz + 3Hz;
Lsig=length(xsig);

ts=0.02; % taxa de amostragem 50 Hz
fator=ts/td;
% envia o sinal a um amostrador
s_out = amostragem(xsig,td,ts);

% calcula a transformada de Fourier
Lfft=2^ceil(log2(Lsig)+1);
Fmax=1/(2*td);
Faxis=linspace(-Fmax,Fmax,Lfft);
Xsig=fftshift(fft(xsig,Lfft));
S_out=fftshift(fft(s_out,Lfft));

% traça gráfico do sinal original e do sinal amostrado nos domínios do 
% tempo e da frequencia

figure(1);
subplot(311); sfig1a=plot(t,xsig,'k');
hold on; sfig1b=plot(t,s_out(1:Lsig),'b'); hold off;
set(sfig1a,'LineWidth',2); set(sfig1b,'LineWidth',2);
xlabel('tempo,segundos');
title('sinal {\it g} ({\it t}) e suas amostras uniformes');

subplot(312); sfig1c=plot(Faxis,abs(Xsig));
xlabel('frequência (Hz)');
axis([-150 150 0 300/fator]);
set(sfig1c,'LineWidth',1);
title('Espectro de {\it g} ({\it t})');

subplot(313); sfig1d=plot(Faxis,abs(S_out));
xlabel('frequência (Hz)');
axis([-150 150 0 300/fator]);
set(sfig1c,'LineWidth',1);
title('Espectro de {\it g}_T ({\it t})');

% calcula o sinal reconstruído a partir de amostragem ideal
% e LPF (filtro passa-baixas) ideal
% Máxima largura do LPF é igual a BW=floor((Lfft/Nfactor)/2);
BW=10; % largura de banda não é maior que 10Hz
H_lpf=zeros(1,Lfft);H_lpf(Lfft/2 - BW:Lfft/2+BW-1)=1; % LPF ideal
S_recv=fator*S_out.*H_lpf; % filtragem ideal
s_recv=real(ifft(fftshift(S_recv))); % domínio da freq. reconstruído
s_recv=s_recv(1:Lsig); % domínio do tempo reconstruído


% traça gráfico do sinal reconstruído idealmente nos domínios do 
% tempo e da frequencia
figure(2);
subplot(211); sfig2a=plot(Faxis,abs(S_recv));
xlabel('frequência (Hz)');
axis([-150 150 0 300]);
title('Espectro de filtragem ideal (reconstrucao)');
subplot(212); sfig2b=plot(t,xsig,'k-.',t,s_recv(1:Lsig),'b');
legend('Sinal original','Sinal reconstruido');
xlabel('tempo,segundos');
title('Sinal original versus Sinal reconstruido idealmente');
set(sfig2b,'LineWidth',2);













