% Diogo Ferreira e Fábio Cunha, 2015
function [ p ] = ProbFalsePositive( m,n,k )
    % Return the probability of a false positive given m elements, n
    % positions in the filter and k hash functions
    % From https://en.wikipedia.org/wiki/Bloom_filter#Probability_of_false_positives
    
    if nargin<2
        return
    end
    
    if nargin<3
        k=3;
    end
    
    p=(1-exp(1)^(-k*m/n))^k;

end

