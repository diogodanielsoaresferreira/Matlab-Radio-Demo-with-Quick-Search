% Diogo Ferreira e Fábio Cunha, 2015
function [ most ] = searchMusic( t, minh, a, c )
    % Recebe uma string com o nome da música a pesquisar e a table de
    % minHash e retorna array com os índices das músicas mais parecidas e o seu valor.
    
	% NOTA: Threshold deve ser aumentado para set's +-maiores do que 2000!
    threshold=0.2;

    sim=minHashSingleDist(minh, musicSingleMinHash(t, a, c));
    most=zeros(2,length(find(sim>=threshold)));
    for i=1:length(find(sim>=0.2))
        m=find(sim==max(sim));
        most(1,i)=m(1,1);
        most(2,i)=max(sim);
        sim(most(1,i))=0;
    end
    
    
end

