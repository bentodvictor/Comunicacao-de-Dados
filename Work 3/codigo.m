clear all; close all; clc;

pkg load signal

Ts = 16; % pontos por simbolo (para cada bit 16x)
Tb = Ts; % tempo de duracao do bit
Nb = 1000; % numero de bits tentando aproximar do infinito 
B=rand(1,Nb) > 0.5; % gera Nb bits aleatoriamente metade estao acima de 0.5 e metade a abaixo
                  %se for menor da bit 0 se for maior da bit 1
T = 1:50 * Tb; % tempo usado para mostrar grafico

% pulsos
% pulso NRZ
pulso_nrz = ones(1, Ts);

% pulso RZ
%pulso_rz = zeros(1, Ts/2);
%pulso_rz(Ts/2:Ts) =  1;

pulso = pulso_nrz;
%pulso = pulso_rz;

%Codificão polar RZ
%RZ = []; 
%for b=B
%    if (b==0)
%        simbolo = -1;
%    else
%        simbolo = 1;
%    end
%    
%    RZ = [RZ simbolo*pulso];
%   
%end
%
%figure;
%subplot(611);
%p=plot(T,RZ(T));
%title('RZ')
%axis([0 length(T) -2 2]);
%set(p,'Color','black','LineWidth',2.5)


%Codificão polar NRZ
NRZ = []; 
for b=B
    if (b==0)
        simbolo = 0;        %Unipolar simbolo = 0
    else
        simbolo = 1;
    end
    
    NRZ = [NRZ simbolo*pulso];
   
end

figure;
subplot(611);
p=plot(T,NRZ(T));
title('NRZ')
axis([0 length(T) -2 2]);
set(p,'Color','black','LineWidth',2.5)

% codigo NRZI
NRZI = [];

simbolo=-1;
for b = B
    if(b==1)
        simbolo = simbolo*(-1);
    end

    NRZI = [NRZI simbolo*pulso];
end

%grafico
subplot(612);
p=plot(T,NRZI(T));
title('NRZI');
axis([0 length(T) -2 2]);
set(p,'Color','black','LineWidth',2.5)

%% Bipolar AMI
AMI = [];

aux = 1;
for b=B
    if (b == 1)
        if (aux == 1)
            simbolo = 1;
            aux = 0;
        else 
            simbolo = -1;
            aux = 1;
        end
    else
         simbolo = 0;
    end

    AMI = [AMI simbolo*pulso];
end

%grafico
subplot(613);
p=plot(T,AMI(T));
title('AMI')
axis([0 length(T) -2 2]);
set(p,'Color','black','LineWidth',2.5)

%PSEUDOTERNARIA
PSEUD = []; 

aux = 1;
for b=B
    if (b == 0)
        if (aux == 1)
            simbolo = 1;
            aux = 0;
        else 
            simbolo = -1;
            aux = 1;
        end
    else
         simbolo = 0;
    end
    
    PSEUD = [PSEUD simbolo*pulso];
        
end

subplot(614);
p=plot(T,PSEUD(T));
title('Pseudoternaria')
axis([0 length(T) -2 2]);
set(p,'Color','black','LineWidth',2.5)

%%MANCHESTER
MANCH=[];

m=1;
for b=B 
    if (b==0)
        simbolo=1; 
    else 
        simbolo=-1;
    end;
    
    MANCH = [MANCH simbolo*pulso(1:Ts/2) (-1)*simbolo*pulso(Ts/2+1:Ts)];
   
end;

subplot(615);
p=plot(T,MANCH(T));
title('Manchester')
axis([0 length(T) -2 2]);
set(p,'Color','black','LineWidth',2.5)

%
%%MANCHESTER DIFERENCIAL 

DIFFMANCH=[];
aux=-1;
for b=B
    if (b==0)
        simbolo=aux; 
    elseif (b==1 && aux==-1) 
        simbolo=1;
        aux=1;
    else
        simbolo=-1;
        aux=-1;
    end;
    
    DIFFMANCH = [DIFFMANCH simbolo*pulso(1:Ts/2) (-1)*simbolo*pulso(Ts/2+1:Ts)];

end;

subplot(616);
p=plot(T,DIFFMANCH(T));
title('Manchester Diferencial')
axis([0 length(T) -2 2]);
set(p,'Color','black','LineWidth',2.5)

%%B8ZS
B8ZS=[];

aux = 1;
count_zero = 0;
for b=B
    if (b == 1)
        count_zero = 0;
        if (aux == 1)
            simbolo = 1;
            aux = 0;
        else 
            simbolo = -1;
            aux = 1;
        end
    else
         simbolo = 0;
         count_zero = count_zero + 1;
    end
    
    if (count_zero == 8)
        
        B8ZS = [B8ZS(1:(end-50)) ((-1)^aux)*pulso (-(-1)^aux)*pulso 0*pulso (-(-1)^aux)*pulso ((-1)^aux)*pulso];
        count_zero = 0;
        
    else 
        B8ZS = [B8ZS simbolo*pulso];     
    end
    
end

%grafico
%subplot(615);
p=plot(T,B8ZS(T));
title('B8ZS')
axis([0 length(T) -2 2]);
set(p,'Color','black','LineWidth',2.5)


%%HDB3
HDB3=[];

aux = 1;
count_zero = 0;
aux_V = 0;
first_one = 1;
for b=B
    if (b == 1)
        count_zero = 0;
        aux_V = aux_V + 1;
        if (aux == 1)
            simbolo = 1;
            aux = 0;
        else 
            simbolo = -1;
            aux = 1;
        end
    else
         simbolo = 0;
         count_zero = count_zero + 1;
    end
    
    if (count_zero == 4)
        if((mod(aux_V,2)~=0) + first_one )
                HDB3 = [HDB3(1:(end)) ((-1)^aux)*pulso];
                first_one = 0;
        else
                 HDB3 = [HDB3(1:(end-50)) (-(-1)^aux)*pulso 0*pulso 0*pulso ((-1)^aux)*pulso];
        end
        aux_V = 0;
        count_zero = 0;
    else 
        HDB3 = [HDB3 simbolo*pulso];     
    end
    
end

%grafico
%subplot(616);
p=plot(T,HDB3(T));
title('HDB3')
axis([0 length(T) -2 2]);
set(p,'Color','black','LineWidth',2.5)



% Calculo de PSDs

% PSD usando metodo de Welch (pode ser usado tambem o periodogram)

figure;
hold on;

%Hpsd=psd(spectrum.welch,NRZ); % matlab
%[Hpsd,f] = pwelch(NRZ); %octave
%handle1=plot(Hpsd);
%set(handle1,'LineWidth',2,'Color','r');

%Hpsd=psd(spectrum.welch,RZ); % matlab
[Hpsd,f] = pwelch(NRZ); %octave
handle1=plot(Hpsd);
set(handle1,'LineWidth',2,'Color','r');

%Hpsd=psd(spectrum.welch,MANCH); % matlab
[Hpsd,f] = pwelch(MANCH); %octave
handle1=plot(Hpsd);
set(handle1,'LineWidth',2,'Color','b')

%Hpsd=psd(spectrum.welch,AMI); % matlab
[Hpsd,f] = pwelch(AMI); ; %octave
handle1=plot(Hpsd);
set(handle1,'LineWidth',2,'Color','g')

%b8z6
%Hpsd=psd(spectrum.welch,MANCH); % matlab
%[b8z6,f] = pwelch(MANCH); %octave
%handle1=plot(b8z6);
%set(handle1,'LineWidth',2,'Color','b')

%Hpsd=psd(spectrum.welch,AMI); % matlab
%[b8z6,f] = pwelch(AMI); ; %octave
%handle1=plot(b8z6);
%set(handle1,'LineWidth',2,'Color','g')

%HDB3
%Hpsd=psd(spectrum.welch,MANCH); % matlab
%[b8z6,f] = pwelch(MANCH); %octave
%handle1=plot(b8z6);
%set(handle1,'LineWidth',2,'Color','b')

%Hpsd=psd(spectrum.welch,AMI); % matlab
%[b8z6,f] = pwelch(AMI); ; %octave
%handle1=plot(b8z6);
%set(handle1,'LineWidth',2,'Color','g')