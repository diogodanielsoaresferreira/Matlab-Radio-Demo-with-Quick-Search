% Diogo Ferreira e F�bio Cunha, 2015
function [ Im ] = SearchPhoto( dir )
    
    % Fun��o que recebe um diret�rio de uma m�sica e, se houver, retorna
    % uma imagem associada.
    % Se a pasta onde a m�sica estiver conter apenas uma imagem, retorna
    % essa imagem. Caso contr�rio, se houver alguma imagem com o mesmo nome
    % da m�sica (exceto as extens�es), mostra essa imagem.
    % Se nada disto acontecer, retorna null retorna uma imagem default.
    
    
    % Divide diret�rio por '\' e obt�m diret�rio da pasta.
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
    % igual � m�sica.
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
    
    % Caso contr�rio, retorna imagem default.
    % Necess�rio inserir endere�o correto da imagem.
    if found==0
        photo='notFound.jpg';
    end
    
    Im=imread(photo);

end

