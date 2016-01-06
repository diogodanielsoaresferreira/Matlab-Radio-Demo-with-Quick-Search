% Diogo Ferreira e Fábio Cunha, 2015
function [k] = OptimalK(m, n)
    % Returns the optimal number of hash functions given m elements and n
    % positions in the filter
    % From https://en.wikipedia.org/wiki/Bloom_filter
    
    if nargin<2
        return
    end
    
    k=round(n*log(2)/m);

end

