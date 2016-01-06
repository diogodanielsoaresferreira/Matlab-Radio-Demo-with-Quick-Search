% Diogo Ferreira e Fábio Cunha, 2015

% Test for BloomFilter and Hash Function
% This function usually takes some time to run(~1/2 minutes)

% Initializing filter
filter=BloomFilter(1e8,10000);


h=waitbar(0,'A testar Strings...');

% Insert Strings
for j=1:10000
    waitbar(j/10000,h)
    str=getRanStr;
    filter.insert(str);
    
    if filter.isMember(str)==0
        disp('Erro na Função Bloom Filter!');
    end
end
delete(h)

% To confirm that isMember is working ok
% Most of them must be 0
filter.isMember('abcdefghijklmonowe')
filter.isMember('diogo')
filter.isMember('qwertyuiip')
filter.isMember('antonio')
filter.isMember('qalberto')