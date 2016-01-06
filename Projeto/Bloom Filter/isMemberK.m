% Diogo Ferreira e Fábio Cunha, 2015
function [ isM ] = isMemberK(filter, key, k)
    
    % Inserts key on filter table
    % If number of arguments is <2, function returns without doing anything
    if nargin<2
        return
    end
    % Default number of hash functions is 3
    if nargin<3
        k=3;
    end
    isM=1;
    for i=1:k
        key=[num2str(i) key];
        if filter(1+rem(string2hash(key),length(filter)))==0
            isM=0;
            return
        end
    end

end
