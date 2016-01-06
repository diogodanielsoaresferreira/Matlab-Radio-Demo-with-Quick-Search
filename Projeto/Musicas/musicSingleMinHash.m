% Diogo Ferreira e Fábio Cunha, 2015
function [ minh ] = musicSingleMinHash( str,a,c )
    
    % Função que calcula minHash apenas para uma String, de acordo com os
    % valores para geração de hash recebidos.
    
    % Separa string de entrada em Shingles
    shingles=strsplit(str,{' ','-','.','','(',')'});
    j=1;
    shinglesname=cell(1,1);
    % Cada shingle é colocado na cell shinglesname.
    % Shinglesname é criado como uma cell 1x1, pois não se sabe à partida qual vai ser o seu
    % tamanho. Como é do tipo cell, não se pode fazer operações
    % vetoriais, pelo que trabalhar com for's pode ficar bastante lento neste caso.
    for k=1:length(shingles(1,:))
        if not(isequal(shingles(1,k),cellstr('mp3')) || isempty(shingles{1,k}))
            shinglesname{j,1}=shingles{1,k};
            j=j+1;
        end
    end
    
    % Calcula as hash para os shingles.
    k=1000;
    hash=zeros(length(shinglesname),k);
    % Número primo>10^7
    p=10000019;
    for j=1:length(shinglesname)
        hash(j,:)=mod(a(1,:)*sum(double(lower(shinglesname{j,1})))+c(1,:),p);
    end
    
    % Cria minHash Table.
    minh=Inf(k,1);
    
    for i=1:k
        for j=1:length(shinglesname)
            minh(i,1)=min(hash(j,i), minh(i,1));
        end
    end
    
end