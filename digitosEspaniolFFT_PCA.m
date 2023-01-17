2%% ESTE SCRIPT PERMITE CARGAR ARCHIVOS DE AUDIO Y APLICAR 
% TRANSFORMADA DE FOURIER Y ANALISIS DE PCA COMO EXTRACTOR DE 
% INFORMACIÓN Y REDUCCION DE DIMENSIONES

%% PROGRAMA PRINCIPAL
%----------------------------------------------------------------
% Creamos variables auxiliares para la lectura de los datos
personas={'alan'};
% Ubicación de los archivos:
ubicacion='grabaciones/alan/';
% Creamos la ruta y nombre del archivo
file=[ubicacion,'0_',personas{1},'_1.mat'];
% Abrimos un archivo para conocer el número de caracteristicas 
datosAudio=load(file);
% Determinamos el número de características
n=round(length(datosAudio.X)/2);

%% ANALISIS DE LOS DÍGITOS EN ESPAÑOL
% Determinamos el número de personas
numPersonas=length(personas);
% Inicializamos la matriz de características
X=zeros(numPersonas*50*10,n);
% Inicializamos el el numero de grabaciones
t=1;
% Analizamos los datos de voz
for p=1:numPersonas
    % Cada persona tiene 10 digitos, 
    % 5 archivos con 10 clips
    for q=0:9          % DIGITO 
        for r=1:5       % ARCHIVO
            % Creamos la ruta y nombre del archivo
            file=[ubicacion,...
                num2str(q), '_', personas{p}, '_',...
                num2str(r), '.mat'];
            % Cargamos el archivo actual de la persona
            datosAudio=load(file);
            for s=1:10  % CLIP
                % Extraemos el s-ésimo clip
                clip=datosAudio.X(:,s);
                % Aplicamos la Transformada de Fourier
                CLIP=fft(clip);
                % Guardamos los datos de la FFT
                X(t,:)=CLIP(1:n);
                % Nos preparamos para la siguiente grabación
                t=t+1;
            end
        end
    end
end
%% GUARDAMOS LA MATRIZ DE CARACTERÍSTICAS
save('XdigitosEspaniol','X');

%% Visualizamos los datos por seccion 
figure('units','normalized','Position',[.25,.1,.50,.87],...
    'name','Visualizacion de Datos');
imagesc(abs(X))