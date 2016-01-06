% Diogo Ferreira e F�bio Cunha, 2015
function [ most ] = SimilarMusics( idx, minH, sim )
    % Fun��o que, recebido um ind�ce de uma m�sica, a matriz de minhash e a
    % matriz de dist�ncia de Jaccard, calcula as m�sicas similares e 
    % devolve uma matriz com o seu �ndice e 
    % a dist�ncia de Jaccard, ordenadas por dist�ncia.
    % Caso a matriz de dist�ncia n�o seja passado como entrada, �
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

