% Diogo Ferreira e Fábio Cunha, 2015
function [ str ] = pathToName( path )
    % Recebe um path e retorna a string com o nome da música.
    
    strarr=strsplit(path,'\');
    str=strarr{length(strarr)};
    
end

