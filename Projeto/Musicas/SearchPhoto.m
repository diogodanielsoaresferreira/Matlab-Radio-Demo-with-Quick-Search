% Diogo Ferreira e Fábio Cunha, 2015
function [ Im ] = SearchPhoto( dir )
    
    % Função que recebe um diretório de uma música e, se houver, retorna
    % uma imagem associada.
    % Se a pasta onde a música estiver conter apenas uma imagem, retorna
    % essa imagem. Caso contrário, se houver alguma imagem com o mesmo nome
    % da música (exceto as extensões), mostra essa imagem.
    % Se nada disto acontecer, retorna null retorna uma imagem default.
    
    
    % Divide diretório por '\' e obtém diretório da pasta.
    photodir=strsplit(dir,'\');
    photo='';
    for i=1:length(photodir)-1
        photo=strcat(photo,photodir{1,i},'\');
    end
    
    % Procura na pasta por imagens.
    allphotos=rdir(strcat(photo,('*.jpg')));
    if isempty(allphotos)
        allphotos=rdir(strcat(photo,('*.png')));
    end
    
    found=0;
    
    % Se apenas houver uma imagem, retorna-a.
    if length(allphotos)==1
        photo=allphotos(1).name;
        found=1;
    % Se houver mais do que uma imagem, retorna a imagem que tiver o nome
    % igual à música.
    elseif length(allphotos)>=0
        for i=1:length(allphotos)
            name=strsplit(allphotos(i).name,'\');
            name=strsplit(name{1,length(name)},'.');
            name2=pathToName(dir);
            name2=strsplit(name2,'.');
            if strcmp(name{1,1},name2{1,1})==1
                 photo=allphotos(i).name;
                 found=1;
                 break;
            end
        end
    end
    
    % Caso contrário, retorna imagem default.
    % Necessário inserir endereço correto da imagem.
    if found==0
        photo='notFound.jpg';
    end
    
    Im=imread(photo);

end

