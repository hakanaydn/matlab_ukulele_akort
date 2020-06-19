clc;clear;

filename = 'notes/A-note.wav';      %440Hz
%filename = 'notes/C-note.wav';    %257Hz
%filename = 'notes/E-note.wav';        %328Hz
%filename = 'notes/G-note.wav';        %391Hz

[audio,Fs] = audioread(filename);

%1.Adým FFT analizi yapilir
NFFT=length(audio);
NFFT2=2.^nextpow2(NFFT);
Freq = Fs.*(0:NFFT2/2-1)/NFFT2;
FFT=fft(audio,NFFT2);
FFT2=FFT(1:NFFT2/2);
FFT_mag=abs(FFT2);

%2.Adým Fundemantel frekasý bulunur
HPS1 = downsample(FFT_mag,1);
HPS2 = downsample(FFT_mag,2);
HPS3 = downsample(FFT_mag,3);

HPS_RES = [];
for i=1:length(HPS3)
      HPS_RES(i) =   HPS1(i)  * HPS2(i) * HPS3(i);
end

maximum = max(max(HPS_RES));
[x,y]=find(HPS_RES==maximum)

FundFreq = y * Fs/NFFT2

FundLen=length(HPS_RES);
FundFrequencyList=(Fs/NFFT2).*(0:FundLen-1);

subplot(2,1,1)
plot(Freq,FFT_mag)
title('FFT Analizi')
xlabel('Frekans(Hz)');
ylabel('Genlik');
grid on;
subplot(2,1,2)
plot(FundFrequencyList,HPS_RES)
title('HPS Analizi')
xlabel('Frekans(Hz)');
grid on;


