%% Captura de audio multiple
% Este script permite grabar audio con un tiempo determinado por 
% tm (segundos), enseguida es posible seleccionar el numer de clips 
% mediante el uso del mouse de manera automatica

%% PROGRAMA PRINCIPAL 
%---------------------------------------------------
close all;
clear ginput;
%% Caracteristicas de grbado
% Frecuencia de muestreo (s/seg) 
fs=8e3; %Ancho de banda de voz human es de 4kHz
% Bits de muestreo
bitsS=16;
%Numero de canales 
numCs=1;
%Objeto para grabar 
sonido = audiorecorder(fs, bitsS,numCs);
%% Caracteristicas de la senal grabada 
%Numero de muestra a grabar 
numDatos =1;
%Tiempo de grabado (seg)
tm=13;
%Matriz que contiene las grabaciones realizadas
%voz=zeros(fs*tm,numDatos);

%% Iniciamos el proceso de grabacion 
%COneo regresivo para alertar al sujeto bajo analisis
for n=1:3 
    clc
    disp([num2str(3-n),'...'])
    pause(1);
end
disp('INICIAMOS GRABACION')
%Se inicia la grabacion 
recordblocking(sonido,tm);
clc
disp('FIN DE LA GRABACION')
%Extraemos los datos 
voz=getaudiodata(sonido);
%% MOSTRAMOS RESULTADOS 
% Figura con los clips perzonalizada
selClips=figure('units','normalized','Position',[.01,.50,.98,.43],...
    'Name','Audio Grabado');
plot(voz);
ylabel('Amplitud de audio (AU)')
xlabel('Numero de muestras')
%% INICIAMOS EL PROCESO SEMIAUTOMATICO DE RECORTE DE CLIPS
% Preguntamos por el ancho de los clips 
%numClips=input('Cuantos clips vamos a procesar?: ');
numClips= 10;
%Preguntamos por el ancho de los clips 
%ancho=input('Cual es el ancho del clip?: ');
ancho=2000;
%Creamos la matriz de datos
X=zeros(2*ancho+1,numClips);

%% Extraccion de clips 
clipRec=figure('units','normalized','Position',[.50,.01,.49,.35],...
    'name','Clips cortados');
for n=1:numClips
    figure(selClips);
    %Extraemos las coordenadas de n-esimo clip
    [x,y]=ginput(1);
    x=round(x);
    %Extraemos el clip 
    X(:,n)=voz(x-ancho : x+ancho);
    %Visualizamos la extraccion 
    figure(clipRec);
    plot(X(:,n))
    xlabel('Numero de muestras');
    ylabel('Amplitud de sonido');
    title(['Clip numero: ', num2str(n)])
    legend('location','westoutside')
    legend('hide')
end

%% Salvamos los datos 
clc 
nameFile= input('Dame el nombre del archivo para salvar los datos: ', 's');
%Establecemos la ubicacion de las grabaciones
ubicacion = 'grabaciones/brau/';
%Creamos la ruta y nombre del archivo
file=[ubicacion,nameFile];
%Salvamos los datos procesados de audio
save(file,'X'); %EVITAR USAR X YA QUE SE USA GENERALMENTE PARA LA MATRIZ DE CARACTERISTICAS






% Programacion orientada a objetos, investigar 


