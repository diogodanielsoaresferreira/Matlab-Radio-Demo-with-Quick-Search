function [ minh ] = minHash(users, movies, Set)

    % Número primo>10^7
    p=10000019;
    hash=zeros(length(movies),1000);
    for i=1:1000
        % Parâmetros das funções de hash.
        a=randi([2,p-2]);
        c=randi([2,p-1]);
        hash(:,i)=mod(a*movies+c,p);
    end
    
    % Inicializa vetor com zeros
    minh=zeros(100,length(users));
    
    % Calcula minhash
    for i=1:100
        for u=1:length(users)
            minh(i,u)=min(hash(Set{users(u)},i));
        end
    end
end
