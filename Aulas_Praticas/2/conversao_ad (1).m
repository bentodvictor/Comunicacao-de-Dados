clear all;close all;  % limpa as vari�veis do matlab e fecha gr�ficos abertos
pkg load signal;    % para o octave

% Exemplo de amostragem e quantiza��o 
td = 0.002; % intervalo entre os pontos do sinal "anal�gico"
t = td:td:1; % intervalo de 1 segundo

%%%%%   inicio da alternativa 3 %%%%%
%xsig=sin(2*1*pi*t)-sin(2*3*pi*t); % seno de 1Hz + 3Hz
%xsig = square(2*pi*3*t); % onda quadrada de 3Hz;
%xsig = sawtooth(2*pi*3*t,0.5); %onda triangular de 3Hz;
%%%%%   fim da alternativa 3   %%%%%

xsig = sin(2*3*pi*t); % seno de 3Hz;
Lsig = length(xsig);

ts = 0.02; % taxa de amostragem 50 Hz
fator = ts/td;

% figura deve ser comentada para plotagem de SQNR x bits
figure(1);
subplot(311); 
sfig1a = plot(t,xsig,'k');
set(sfig1a,'LineWidth',2); 
xlabel('tempo,segundos');
title('sinal');

%%%%%%  for para pegar cada ponto de SQNR referente a cada bit   %%%%%%
%for bits = 3:16
amp = 2;     
amp = max(xsig);
% variavel bits deve comentada pelo quando usar for
bits = 3;  % numero de bits da conversão anal�gico/digital
n = 2^bits; % numero de niveis



% envia o sinal a um amostrador e quantizador
[s_out,sq_out] = amostra_quant(xsig,td,ts,amp,n);

% segundo gr�fico deve ser comentado para plotagem do grafico da interpola��o
subplot(312);
stem(t,s_out,'b','filled');     % sinal amostrado
hold on;
stem(t,sq_out,'r', 'filled');   % sinal amostrado e quantizado

% ruido de quantizacao
sr = s_out - sq_out; % erro de quantiza��o 
emq = sr*sr'/length(sr); % erro medio quadratico
% quando usar o for, mudar SQNR para SQNR(bits)
SQNR = 20*log10(norm(s_out)/norm(sr)); % valor da SQNR  
%end
%%%%%%    end for   %%%%%%

sfig1b = plot(t,sr,'k');
set(sfig1b,'LineWidth',2);
axis([0 1 -2 2]);
xlabel('tempo,segundos');
title('sinal {\it g} ({\it t}) e suas amostras uniformes e quantizadas');

% diferen�a entre sinal e ruido
subplot(313);
sfig1c = plot(t,xsig);
hold on;
stem(t,sq_out,'r','filled');
set(sfig1c,'LineWidth',2);
axis([0 1 -2 2]);
xlabel('tempo,segundos');
title('sinal {\it g} ({\it t}) e suas amostras uniformes e quantizadas');


%%%%%  modifica��es para plotagem dos gr�ficos exigidos %%%%%
%bit = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16];   % auxiliar para pegar numero de bits

%%%%% gr�fico normal  %%%%%
%figure(1);
%subplot(311); 
%sfig1a = plot(bit,SQNR,'g'); 
%set(sfig1a,'LineWidth',2);
%xlabel('bits');
%ylabel('SQNR');
%title('SQNR x bits');

%%%%%   gr�fico imterpolado    %%%%%
%p = polyfit(bit, SQNR, 1);    %fun��o que retorna a interpola��o (x, y, grau do polinomio)
%figure(1)
%subplot(312);
%x = linspace(0, 16);    %gera um vetor de pontos para ser interpolados
%y = polyval(p, x);     %Resolve o polinomio nos pontos do novo vetor x
%plot(bit, SQNR,'ko');  %plota o gr�fico SQNR x bits
%hold on               % segura o grafico na tela
%plot(x,y, 'g');       % plota o grafico da interpola��o na tela 
%xlabel('bits')
%ylabel('SQNR');
%title('IMTERPOLA��O');
%hold of               % jun��o da interpola��o

