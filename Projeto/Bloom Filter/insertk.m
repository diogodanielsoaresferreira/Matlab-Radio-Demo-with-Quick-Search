% Diogo Ferreira e Fábio Cunha, 2015
function [ filter ] = insertk(filter, key, k)
    
    % Inserts key on filter table
    % If number of arguments is <2, function returns without doing anything
    if nargin<2
        return
    end
    % Default number of hash functions is 3
    if nargin<3
        k=3;
    end
    
    for i=1:k
        key=[num2str(i) key];
        filter(1+rem(string2hash(key),length(filter)))=1;
    end

end
