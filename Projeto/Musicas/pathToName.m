% Diogo Ferreira e F�bio Cunha, 2015
function [ str ] = pathToName( path )
    % Recebe um path e retorna a string com o nome da m�sica.
    
    strarr=strsplit(path,'\');
    str=strarr{length(strarr)};
    
end

