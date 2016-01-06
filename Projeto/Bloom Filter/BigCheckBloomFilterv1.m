% Diogo Ferreira e Fábio Cunha, 2015
% Big check to Bloom Filter

% Size of the filter
n=8000;
filter=initializeFilter(n);

% Number of hash functions
k=3;

% Insert 1000 strings
j=1000;
h = waitbar(0,'A inserir strings...');
for i=1:j
    waitbar(i/(j+10000),h);
    filter=insert(filter, getRanStr());
end

% Calculates collisions
colisions=j*k-sum(filter);
waitbar((j)/(j+10000),h,'A testar novas strings...');

% Tests if new random generated strings match with filter.
totalMembers=zeros(10000,1);
for i=1:10000
    waitbar((j+i)/(j+10000),h);
    totalMembers(i,1)=isMember(filter, getRanStr());
end
delete(h);
totalMatches=sum(totalMembers);

% Plot to check if distribution is uniform
stem(1:n,filter);
title({'Posições do filtro'})