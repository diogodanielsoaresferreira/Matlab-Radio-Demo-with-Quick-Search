% Diogo Ferreira e F�bio Cunha, 2015
function [ sim ] = minHashSingleDist( minh, minh2 )
    
    % Calcula dist�ncia baseada no minHash de um set e no minHash de uma
    % string.
    sim=zeros(length(minh(1,:)),1);
    for i=1:length(minh(1,:))
        sim(i,1)=sum(minh(:,i)==minh2(:,1))/length(minh(:,1));
    end

end
