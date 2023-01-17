%% Este codigo peromite la vizualizacion del espectograma de un archivo de audio 


%% Programa principal 
%Cargamos el archivo de audio 
load("grabaciones/alan/0_alan_1.mat")
audio = X;
% Parametros del expectograma 
dxv= 256; %dxv= Datos x Ventana
tras=250; %tras = traslape
ndefrec=256; %ndefrec = numero de frecuencias 
fs= 8e3; %frecuencia de muestreo 
%Desarrollamos el especotrgrama del primer archivo 
for q=1:10
spectrogram(audio(:,q),dxv,tras,ndefrec,fs,'yaxis')
pause(.1)
end
