% Diogo Ferreira e F�bio Cunha, 2015
function [ sim ] = minHashDist( minh)
    
    % Calcula dist�ncia baseada no minHash
    sim=zeros(length(minh(1,:)),length(minh(1,:)));
    h=waitbar(0,'A criar matriz de dist�ncia de Jaccard com minHash');
    for i=1:length(minh(1,:))
        waitbar(i/length(minh(1,:)), h)
        for j=i+1:length(minh(1,:))
            sim(i,j)=sum(minh(:,i)==minh(:,j))/length(minh(:,1));
        end
    end
    delete(h);

end

