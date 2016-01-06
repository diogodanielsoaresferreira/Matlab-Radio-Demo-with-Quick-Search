% Diogo Ferreira e Fábio Cunha, 2015
function [ filter ] = initializeFilter( n )
    % Initializes the filter with n zeros
    if(nargin<1)
        n=10000;
    end
    
    filter=zeros(1,n);

end

