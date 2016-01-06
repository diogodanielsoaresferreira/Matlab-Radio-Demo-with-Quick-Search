% Diogo Ferreira e Fábio Cunha, 2015
function [ most ] = SimilarMusics( idx, minH, sim )
    % Função que, recebido um indíce de uma música, a matriz de minhash e a
    % matriz de distância de Jaccard, calcula as músicas similares e 
    % devolve uma matriz com o seu índice e 
    % a distância de Jaccard, ordenadas por distância.
    % Caso a matriz de distância não seja passado como entrada, é
    % calculada, podendo demorar algum tempo (dependendo do seu tamanho (Complexidade O(n^2))).
    
    % NOTA: Threshold deve ser aumentado para set's +-maiores do que 2000!
    threshold=0.2;
    if nargin==2
        sim=minHashDist(minH);
    end
    sim=sim(:,idx);
    most=zeros(2,length(find(sim>=threshold)));
    for i=1:length(find(sim>=threshold))
        m=find(sim==max(sim));
        most(1,i)=m(1,1);
        most(2,i)=max(sim);
        sim(most(1,i))=0;
    end
    
end

