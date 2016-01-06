% Diogo Ferreira e Fábio Cunha, 2015
function [ hash ] = DJB31MA( s, seed )
    
    % Hash function that receives a seed to generate hashcode.
    % From: Paulo Jorge Ferreira "MPEI – summary" 2014
    if nargin<1
        return
    end
    % 127 is a Mersenne Prime Number (like 3, 7, 31,...)
    if nargin<2
        seed=127;
    end

    hash=seed;
    for i=1:length(s)
        hash=31*hash+s(i);
    end
    
end